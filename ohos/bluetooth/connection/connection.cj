/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// The Cangjie API is in Beta. For details on its capabilities and limitations, please refer to the README file.

package ohos.bluetooth.connection

import ohos.bluetooth.{ BLUETOOTH_LOG, OPERATION_FAILED, getErrorMsg, normalizeInnerCode, CallbackController }
import ohos.bluetooth.constant.{ ProfileConnectionState, ProfileId }
import ohos.business_exception.{ AsyncCallback, BusinessException }
import ohos.callback_invoke.{ Callback1Argument, CallbackObject }
import ohos.ffi.{ CArrString, Callback1Param, SUCCESS_CODE, cArr2cjArr }
// Star import: the String <: PermissionValue extension (operator &) that the
// dual-permission annotation of setDevicePairingConfirmation relies on is only
// visible with the whole ohos.labels package imported.
import ohos.labels.*

import std.collection.HashMap
import std.sync.Mutex

private func parseProfileConnectionState(state: Int32): ProfileConnectionState {
    // D7-a (interim A1): a value outside the declared 0-3 domain surfaces as
    // OPERATION_FAILED on query paths instead of an undeclared conversion
    // exception; the shared ProfileConnectionState.parse is range-guarded here.
    if (state < 0i32 || state > 3i32) {
        throw BusinessException(OPERATION_FAILED, getErrorMsg(OPERATION_FAILED))
    }
    ProfileConnectionState.parse(state)
}

/**
 * Get the profile connection state of the current device.
 *
 * @param { ?ProfileId } [profileId] - Indicate the profile id. This is an optional parameter.
 *     With profileId, returns the current connection state of this profile, ProfileConnectionState.
 *     Without profileId, if any profile is connected, ProfileConnectionState.StateConnected is returned.
 *     Otherwise, ProfileConnectionState.StateDisconnected is returned.
 * @returns { ProfileConnectionState } Returns the connection state.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900001 - Service stopped.
 * @throws { BusinessException } 2900003 - Bluetooth disabled.
 * @throws { BusinessException } 2900004 - Profile not supported.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    throwexception: true
]
public func getProfileConnectionState(profileId!: ?ProfileId = None): ProfileConnectionState {
    var errorCode: Int32 = 0
    var state: Int32 = 0
    if (let Some(id) <- profileId) {
        unsafe {
            state = FfiBluetoothConGetProfileConnectionState(id.getValue(), inout errorCode)
        }
        checkRetKeep401(errorCode)
        return parseProfileConnectionState(state)
    }
    // D1-A: the aggregated host state shares the ArkTS data source; the native
    // side maps it to the API value domain and the omitted-parameter path is
    // normalized to the two states promised by the declaration.
    unsafe {
        state = FfiBluetoothConGetBtConnectionState(inout errorCode)
    }
    checkRetKeep401(errorCode)
    if (parseProfileConnectionState(state) == ProfileConnectionState.StateConnected) {
        return ProfileConnectionState.StateConnected
    }
    return ProfileConnectionState.StateDisconnected
}

/**
 * Starts pairing with a remote Bluetooth device.
 *
 * @param { String } deviceId - Indicates device ID. For example, "11:22:33:AA:BB:FF".
 * @param { AsyncCallback<Unit> } callback - the callback of pairDevice.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900001 - Service stopped.
 * @throws { BusinessException } 2900003 - Bluetooth disabled.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    throwexception: true
]
public func pairDevice(deviceId: String, callback: AsyncCallback<Unit>): Unit {
    spawn {
        pairDeviceAndCallback(deviceId, callback)
    }
    return
}

// D3: the request result is reported exactly once (success or failure); a
// successful request does not mean the bonding completed - the bonding result
// is observed through onBondStateChange.
private func pairDeviceAndCallback(deviceId: String, callback: AsyncCallback<Unit>): Unit {
    var errorCode: Int32 = 0
    unsafe {
        try (id = LibC.mallocCString(deviceId).asResource()) {
            FfiBluetoothConPairDevice(id.value, inout errorCode)
        }
    }
    if (errorCode != SUCCESS_CODE) {
        // F1a: negative inner codes are outside the declared error-code
        // surface; normalize them to 2900099 like the ArkTS napi layer.
        let code = normalizeInnerCode(errorCode)
        callback(BusinessException(code, getErrorMsg(code)), None<Unit>)
        return
    }
    callback(None<BusinessException>, Some(()))
}

/**
 * Obtains the name or alias of the Bluetooth peer device.
 *
 * @permission ohos.permission.ACCESS_BLUETOOTH
 * @param { String } deviceId - Indicates device ID. For example, "11:22:33:AA:BB:FF".
 * @returns { String } Returns the device name in character string format.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900001 - Service stopped.
 * @throws { BusinessException } 2900003 - Bluetooth disabled.
 * @throws { BusinessException } 2900099 - Failed to obtain the name or alias of the peer Bluetooth device.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    throwexception: true
]
public func getRemoteDeviceName(deviceId: String): String {
    var errorCode: Int32 = 0
    var name = ""
    unsafe {
        try (id = LibC.mallocCString(deviceId).asResource()) {
            let cName = FfiBluetoothConGetRemoteDeviceName(id.value, inout errorCode)
            try {
                // D7-b: the error code is checked before the value is touched.
                checkRetKeep401(errorCode)
                // D7-c: an unnamed device yields a null CString.
                name = if (cName.isNull()) { "" } else { cName.toString() }
            } finally {
                LibC.free(cName)
            }
        }
    }
    return name
}

/**
 * Obtains the class of a peer Bluetooth device.
 *
 * @param { String } deviceId - Indicates device ID. For example, "11:22:33:AA:BB:FF".
 * @returns { DeviceClass } The class of the remote device.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900001 - Service stopped.
 * @throws { BusinessException } 2900003 - Bluetooth disabled.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func getRemoteDeviceClass(deviceId: String): DeviceClass {
    var errorCode: Int32 = 0
    var cDeviceClass = CDeviceClass(0i32, 0i32, 0i32)
    unsafe {
        try (id = LibC.mallocCString(deviceId).asResource()) {
            cDeviceClass = FfiBluetoothConGetRemoteDeviceClass(id.value, inout errorCode)
        }
    }
    checkRetKeep401(errorCode)
    return cDeviceClass.toObject()
}

/**
 * Obtains the Bluetooth local name of a device.
 *
 * @permission ohos.permission.ACCESS_BLUETOOTH
 * @returns { String } Returns the name the device.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900001 - Service stopped.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    throwexception: true
]
public func getLocalName(): String {
    var errorCode: Int32 = 0
    var name = ""
    unsafe {
        let cName = FfiBluetoothConGetLocalName(inout errorCode)
        try {
            checkRetKeep401(errorCode)
            // D7-c: an unnamed device yields a null CString.
            name = if (cName.isNull()) { "" } else { cName.toString() }
        } finally {
            LibC.free(cName)
        }
    }
    return name
}

/**
 * Obtains the list of Bluetooth devices that have been paired with the current device.
 *
 * @returns { Array<String> } Returns a list of paired Bluetooth devices's address.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900001 - Service stopped.
 * @throws { BusinessException } 2900003 - Bluetooth disabled.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    throwexception: true
]
public func getPairedDevices(): Array<String> {
    var errorCode: Int32 = 0
    var devices = Array<String>()
    unsafe {
        let cDevices = FfiBluetoothConGetPairedDevices(inout errorCode)
        try {
            checkRetKeep401(errorCode)
            if (cDevices.head.isNull()) {
                return devices
            }
            devices = cArr2cjArr<CString, String>(cDevices.size, cDevices.head) {
                str: CString => str.toString()
            }
        } finally {
            cDevices.free()
        }
    }
    return devices
}

/**
 * Obtains the pair state of a specified device.
 *
 * @permission ohos.permission.ACCESS_BLUETOOTH
 * @param { String } deviceId - Indicates device ID. For example, "11:22:33:AA:BB:FF".
 * @returns { BondState } Returns the pair state.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900001 - Service stopped.
 * @throws { BusinessException } 2900003 - Bluetooth disabled.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    throwexception: true
]
public func getPairState(deviceId: String): BondState {
    var errorCode: Int32 = 0
    var state: Int32 = 0
    unsafe {
        try (id = LibC.mallocCString(deviceId).asResource()) {
            state = FfiBluetoothConGetPairState(id.value, inout errorCode)
        }
    }
    // D7-b: the error code is checked before the value is parsed; the native
    // quirk of returning Bonding(1) with errCode 401 therefore surfaces as 401.
    checkRetKeep401(errorCode)
    if (let Some(bondState) <- BondState.parse(state)) {
        return bondState
    }
    throw BusinessException(OPERATION_FAILED, getErrorMsg(OPERATION_FAILED))
}

/**
 * Sets the confirmation of pairing with a certain device.
 *
 * @permission ohos.permission.ACCESS_BLUETOOTH and ohos.permission.MANAGE_BLUETOOTH
 * @param { String } deviceId - Indicates device ID. For example, "11:22:33:AA:BB:FF".
 * @param { Bool } accept - Indicates whether to accept the pairing request, {@code true} indicates accept or
 *     {@code false} otherwise.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900001 - Service stopped.
 * @throws { BusinessException } 2900003 - Bluetooth disabled.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    permission: "ohos.permission.ACCESS_BLUETOOTH" & "ohos.permission.MANAGE_BLUETOOTH",
    throwexception: true
]
public func setDevicePairingConfirmation(deviceId: String, accept: Bool): Unit {
    var errorCode: Int32 = 0
    unsafe {
        try (id = LibC.mallocCString(deviceId).asResource()) {
            FfiBluetoothConSetDevicePairingConfirmation(id.value, accept, inout errorCode)
        }
    }
    checkRetKeep401(errorCode)
}

/**
 * Set the pin during pairing when the pin type is PIN_TYPE_ENTER_PIN_CODE.
 *
 * @permission ohos.permission.ACCESS_BLUETOOTH
 * @param { String } deviceId - Indicates device ID. For example, "11:22:33:AA:BB:FF".
 * @param { String } code - The pin code entered by the user.
 * @param { AsyncCallback<Unit> } callback - the callback of setDevicePinCode.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900001 - Service stopped.
 * @throws { BusinessException } 2900003 - Bluetooth disabled.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    throwexception: true
]
public func setDevicePinCode(deviceId: String, code: String, callback: AsyncCallback<Unit>): Unit {
    spawn {
        setDevicePinCodeAndCallback(deviceId, code, callback)
    }
    return
}

private func setDevicePinCodeAndCallback(deviceId: String, code: String,
                                         callback: AsyncCallback<Unit>): Unit {
    var errorCode: Int32 = 0
    unsafe {
        try (
            id = LibC.mallocCString(deviceId).asResource(),
            cCode = LibC.mallocCString(code).asResource()
        ) {
            FfiBluetoothConSetDevicePinCode(id.value, cCode.value, inout errorCode)
        }
    }
    if (errorCode != SUCCESS_CODE) {
        // F1a: negative inner codes are outside the declared error-code
        // surface; normalize them to 2900099 like the ArkTS napi layer.
        let code = normalizeInnerCode(errorCode)
        callback(BusinessException(code, getErrorMsg(code)), None<Unit>)
        return
    }
    callback(None<BusinessException>, Some(()))
}

/**
 * Sets the Bluetooth scan mode for a device.
 *
 * @param { ScanMode } mode - Indicates the Bluetooth scan mode to set.
 * @param { Int32 } duration - Indicates the duration in seconds, in which the host is discoverable.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900001 - Service stopped.
 * @throws { BusinessException } 2900003 - Bluetooth disabled.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    throwexception: true
]
public func setBluetoothScanMode(mode: ScanMode, duration: Int32): Unit {
    var errorCode: Int32 = 0
    unsafe {
        FfiBluetoothConSetBluetoothScanMode(mode.getValue(), duration, inout errorCode)
    }
    checkRetKeep401(errorCode)
}

/**
 * Obtains the Bluetooth scanning mode of a device.
 *
 * @permission ohos.permission.ACCESS_BLUETOOTH
 * @returns { ScanMode } Returns the Bluetooth scanning mode.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900001 - Service stopped.
 * @throws { BusinessException } 2900003 - Bluetooth disabled.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    throwexception: true
]
public func getBluetoothScanMode(): ScanMode {
    var errorCode: Int32 = 0
    var mode: Int32 = 0
    unsafe {
        mode = FfiBluetoothConGetBluetoothScanMode(inout errorCode)
    }
    // D7-b: the error code is checked before the value is parsed.
    checkRetKeep401(errorCode)
    if (let Some(scanMode) <- ScanMode.parse(mode)) {
        return scanMode
    }
    throw BusinessException(OPERATION_FAILED, getErrorMsg(OPERATION_FAILED))
}

/**
 * Starts scanning Bluetooth devices.
 *
 * @permission ohos.permission.ACCESS_BLUETOOTH
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900001 - Service stopped.
 * @throws { BusinessException } 2900003 - Bluetooth disabled.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    throwexception: true
]
public func startBluetoothDiscovery(): Unit {
    var errorCode: Int32 = 0
    unsafe {
        FfiBluetoothConStartBluetoothDiscovery(inout errorCode)
    }
    checkRetKeep401(errorCode)
}

/**
 * Stops Bluetooth device scanning.
 *
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900001 - Service stopped.
 * @throws { BusinessException } 2900003 - Bluetooth disabled.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    throwexception: true
]
public func stopBluetoothDiscovery(): Unit {
    var errorCode: Int32 = 0
    unsafe {
        FfiBluetoothConStopBluetoothDiscovery(inout errorCode)
    }
    checkRetKeep401(errorCode)
}

/**
 * Check if bluetooth is discovering.
 *
 * @returns { Bool } Returns {@code true} if the local device is discovering; returns {@code false} otherwise.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900001 - Service stopped.
 * @throws { BusinessException } 2900003 - Bluetooth disabled.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    throwexception: true
]
public func isBluetoothDiscovering(): Bool {
    var errorCode: Int32 = 0
    var isDiscovering = false
    unsafe {
        isDiscovering = FfiBluetoothConIsBluetoothDiscovering(inout errorCode)
    }
    checkRetKeep401(errorCode)
    return isDiscovering
}

// D2: the dedicated-name surface carries no event type parameter; the native
// REGISTER_* event constants stay package-internal. There is no native
// unregister entry - the local registry below is the single source of truth
// and a repeated FfiBluetoothConOn for the same event replaces the trampoline.
private let BATTERY_CHANGE_TYPE: Int32 = 0
private let DEVICE_FIND_TYPE: Int32 = 1
private let BOND_STATE_CHANGE_TYPE: Int32 = 2
private let PIN_REQUIRED_TYPE: Int32 = 3

private let GLOBAL_CALLBACK_MAP = HashMap<Int32, CallbackController>(
    [
        (BATTERY_CHANGE_TYPE, CallbackController()),
        (DEVICE_FIND_TYPE, CallbackController()),
        (BOND_STATE_CHANGE_TYPE, CallbackController()),
        (PIN_REQUIRED_TYPE, CallbackController())
    ]
)

private func register(callbackType: Int32, id: Int64): Unit {
    var errorCode: Int32 = 0
    unsafe {
        FfiBluetoothConOn(callbackType, id, inout errorCode)
    }
    checkRetKeep401(errorCode)
}

private func argWrapper1<CT, T>(controller: CallbackController, ctor: (CT) -> ?T): Int64
where CT <: CType {
    let wrapper = {
        ctype: CT =>
        if (let Some(value) <- ctor(ctype)) {
            controller.invokeCallback(value)
        } else {
            // D7-a: conversion failures are isolated on callback paths; an
            // exception must never cross the FFI callback border.
            BLUETOOTH_LOG.error("drop connection event: native payload conversion failed")
        }
    }
    let registerCall = Callback1Param<CT, Unit>(wrapper)
    registerCall.getID()
}

// T06/F-1: guards the check-native-register-enable-add sequence of every
// subscription entry; see the comment inside commonSubscribe1Arg.
private let subscribeMut = Mutex()

private func commonSubscribe1Arg<CT, T>(callbackType: Int32, callback: CallbackObject,
    ctor: (CT) -> ?T): Unit where CT <: CType {
    BLUETOOTH_LOG.debug("subscribe connection event ${callbackType}")
    let controller = GLOBAL_CALLBACK_MAP[callbackType]
    // T06/F-1: the sequence below must be atomic. Without the guard, two
    // threads making the first subscription for the same event could both
    // register natively (orphaning one trampoline - the native side has no
    // unregister entry) and interleave around the unlocked enableController()
    // list swap so one subscription is silently lost. synchronized releases
    // the monitor on exceptional exit, so a BusinessException thrown by
    // register() cannot wedge the guard.
    synchronized (subscribeMut) {
        if (!controller.isEnabled()) {
            register(callbackType, argWrapper1<CT, T>(controller, ctor))
            controller.enableController()
        } else {
            if (controller.hasCallback(callback)) {
                BLUETOOTH_LOG.info("The connection event ${callbackType} callback is registered, no need to re-registered")
                return
            }
        }
        controller.addCallback(callback)
    }
}

private func commonUnsubscribe<T>(callbackType: Int32, callback: ?Callback1Argument<T>): Unit {
    BLUETOOTH_LOG.debug("unsubscribe connection event ${callbackType}")
    let controller = GLOBAL_CALLBACK_MAP[callbackType]
    if (!controller.isEnabled()) {
        return
    }
    if (let Some(v) <- callback) {
        controller.removeCallback(v)
        return
    }
    controller.removeAllCallback()
    return
}

/**
 * Subscribe the event reported when a remote Bluetooth device is discovered.
 *
 * @param { Callback1Argument<Array<String>> } callback - Callback used to listen for the discovering event.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    throwexception: true
]
public func onBluetoothDeviceFind(callback: Callback1Argument<Array<String>>): Unit {
    commonSubscribe1Arg<CArrString, Array<String>>(DEVICE_FIND_TYPE, callback) {
        devices: CArrString => unsafe {
            if (devices.head.isNull()) {
                Some(Array<String>())
            } else {
                Some(cArr2cjArr<CString, String>(devices.size, devices.head) {
                    str: CString => str.toString()
                })
            }
        }
    }
    return
}

/**
 * Unsubscribe the event reported when a remote Bluetooth device is discovered.
 *
 * @param { ?Callback1Argument<Array<String>> } [callback] - Callback used to listen for the discovering event.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    throwexception: true
]
public func offBluetoothDeviceFind(callback!: ?Callback1Argument<Array<String>> = None): Unit {
    commonUnsubscribe(DEVICE_FIND_TYPE, callback)
}

/**
 * Subscribe the event reported when a remote Bluetooth device is bonded.
 *
 * @permission ohos.permission.ACCESS_BLUETOOTH
 * @param { Callback1Argument<BondStateParam> } callback - Callback used to listen for the bond state event.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    throwexception: true
]
public func onBondStateChange(callback: Callback1Argument<BondStateParam>): Unit {
    commonSubscribe1Arg<CBondStateParam, BondStateParam>(BOND_STATE_CHANGE_TYPE, callback) {
        param: CBondStateParam => param.toObject()
    }
    return
}

/**
 * Unsubscribe the event reported when a remote Bluetooth device is bonded.
 *
 * @param { ?Callback1Argument<BondStateParam> } [callback] - Callback used to listen for the bond state event.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    throwexception: true
]
public func offBondStateChange(callback!: ?Callback1Argument<BondStateParam> = None): Unit {
    commonUnsubscribe(BOND_STATE_CHANGE_TYPE, callback)
}

/**
 * Subscribe the event of a pairing request from a remote Bluetooth device.
 *
 * @param { Callback1Argument<PinRequiredParam> } callback - Callback used to listen for the pairing request event.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    throwexception: true
]
public func onPinRequired(callback: Callback1Argument<PinRequiredParam>): Unit {
    commonSubscribe1Arg<CPinRequiredParam, PinRequiredParam>(PIN_REQUIRED_TYPE, callback) {
        param: CPinRequiredParam => Some(param.toObject())
    }
    return
}

/**
 * Unsubscribe the event of a pairing request from a remote Bluetooth device.
 *
 * @param { ?Callback1Argument<PinRequiredParam> } [callback] - Callback used to listen for the pairing request event.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    throwexception: true
]
public func offPinRequired(callback!: ?Callback1Argument<PinRequiredParam> = None): Unit {
    commonUnsubscribe(PIN_REQUIRED_TYPE, callback)
}

/**
 * Subscribe the event of battery state changed from a remote device.
 *
 * @param { Callback1Argument<BatteryInfo> } callback - Callback used to listen.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    throwexception: true
]
public func onBatteryChange(callback: Callback1Argument<BatteryInfo>): Unit {
    commonSubscribe1Arg<CBatteryInfo, BatteryInfo>(BATTERY_CHANGE_TYPE, callback) {
        info: CBatteryInfo => info.toObject()
    }
    return
}

/**
 * Unsubscribe the event of battery state changed from a remote device.
 *
 * @param { ?Callback1Argument<BatteryInfo> } [callback] - Callback used to listen.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    throwexception: true
]
public func offBatteryChange(callback!: ?Callback1Argument<BatteryInfo> = None): Unit {
    commonUnsubscribe(BATTERY_CHANGE_TYPE, callback)
}
