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

package ohos.bluetooth.access

import ohos.bluetooth.{ BLUETOOTH_LOG, OPERATION_FAILED, getErrorMsg, CallbackController }
import ohos.business_exception.BusinessException
import ohos.callback_invoke.Callback1Argument
import ohos.ffi.{ Callback1Param, SUCCESS_CODE }
import ohos.labels.APILevel

import std.deriving.Derive

/**
 * Checks the FFI error code for the access package.
 *
 * Unlike the shared checkRet, which normalizes 401 to 2900099, this helper
 * passes 401 through to align with the ArkTS runtime (decision D7-d).
 * 401 is not part of the declared @throws set; the behavior difference is
 * intentional and disclosed in the PR description.
 */
private func checkRetKeep401(errorCode: Int32): Unit {
    if (errorCode != SUCCESS_CODE) {
        throw BusinessException(errorCode, getErrorMsg(errorCode))
    }
}

/**
 * The enum of bluetooth state.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum BluetoothState {
    /**
     * Indicates the local Bluetooth is off.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StateOff
    |
    /**
     * Indicates the local Bluetooth is turning on.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StateTurningOn
    |
    /**
     * Indicates the local Bluetooth is on, and ready for use.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StateOn
    |
    /**
     * Indicates the local Bluetooth is turning off.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StateTurningOff
    |
    /**
     * Indicates the local Bluetooth is turning LE mode on.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StateBleTurningOn
    |
    /**
     * Indicates the local Bluetooth is in LE only mode.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StateBleOn
    |
    /**
     * Indicates the local Bluetooth is turning off LE only mode.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StateBleTurningOff
    | ...

    /**
     * Parses the native bluetooth state value. Returns None for values outside
     * the declared range (for example the native STATE_BLE_OWNER_MODE); callers
     * apply the D7-a boundary rule.
     */
    protected static func parse(state: Int32): ?BluetoothState {
        match (state) {
            case 0i32 => Some(StateOff)
            case 1i32 => Some(StateTurningOn)
            case 2i32 => Some(StateOn)
            case 3i32 => Some(StateTurningOff)
            case 4i32 => Some(StateBleTurningOn)
            case 5i32 => Some(StateBleOn)
            case 6i32 => Some(StateBleTurningOff)
            case _ => None
        }
    }
}

/**
 * Enables Bluetooth on a device.
 *
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
public func enableBluetooth(): Unit {
    var errorCode: Int32 = 0
    unsafe {
        FfiBluetoothAccEnableBluetooth(inout errorCode)
    }
    checkRetKeep401(errorCode)
}

/**
 * Disables Bluetooth on a device.
 *
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
public func disableBluetooth(): Unit {
    var errorCode: Int32 = 0
    unsafe {
        FfiBluetoothAccDisableBluetooth(inout errorCode)
    }
    checkRetKeep401(errorCode)
}

/**
 * Obtains the Bluetooth status of a device.
 *
 * @returns { BluetoothState } Returns the Bluetooth status.
 * @throws { BusinessException } 201 - Permission denied. [since 10 - 12]
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
public func getState(): BluetoothState {
    var errorCode: Int32 = 0
    var state: Int32 = 0
    unsafe {
        state = FfiBluetoothAccGetState(inout errorCode)
    }
    // D7-b: the error code is checked before the value is parsed.
    checkRetKeep401(errorCode)
    // D7-a (interim A1): a native value outside the declared range (such as
    // STATE_BLE_OWNER_MODE) surfaces as OPERATION_FAILED instead of an
    // undeclared conversion exception.
    if (let Some(btState) <- BluetoothState.parse(state)) {
        return btState
    }
    throw BusinessException(OPERATION_FAILED, getErrorMsg(OPERATION_FAILED))
}

// D2: the dedicated-name surface carries no event type parameter; the native
// REGISTER_STATE_CHANGE_TYPE constant stays package-internal. There is no
// native unregister entry - the local controller is the single source of
// truth and a repeated FfiBluetoothAccOn replaces the trampoline.
private let REGISTER_STATE_CHANGE_TYPE: Int32 = 0

private let controller = CallbackController()

private func argWrapper1<CT, T>(ctor: (CT) -> ?T): Int64 where CT <: CType {
    let wrapper = {
        ctype: CT =>
        if (let Some(value) <- ctor(ctype)) {
            controller.invokeCallback(value)
        } else {
            // D7-a: conversion failures are isolated on callback paths; an
            // exception must never cross the FFI callback border.
            BLUETOOTH_LOG.error("drop state change event: unknown state value")
        }
    }
    let registerCall = Callback1Param<CT, Unit>(wrapper)
    registerCall.getID()
}

/**
 * Subscribe the event reported when the Bluetooth state changes.
 *
 * @param { Callback1Argument<BluetoothState> } callback - Callback used to listen for the Bluetooth state event.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func onStateChange(callback: Callback1Argument<BluetoothState>): Unit {
    BLUETOOTH_LOG.debug("subscribe stateChange callback")
    if (!controller.isEnabled()) {
        var errorCode: Int32 = 0
        let id = argWrapper1<Int32, BluetoothState>({
            state: Int32 => BluetoothState.parse(state)
        })
        unsafe {
            FfiBluetoothAccOn(REGISTER_STATE_CHANGE_TYPE, id, inout errorCode)
        }
        checkRetKeep401(errorCode)
        controller.enableController()
    } else {
        if (controller.hasCallback(callback)) {
            BLUETOOTH_LOG.info("The stateChange callback is registered, no need to re-registered")
            return
        }
    }
    controller.addCallback(callback)
}

/**
 * Unsubscribe the event reported when the Bluetooth state changes.
 *
 * @param { ?Callback1Argument<BluetoothState> } [callback] - Callback used to listen for the Bluetooth state event.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func offStateChange(callback!: ?Callback1Argument<BluetoothState> = None): Unit {
    BLUETOOTH_LOG.debug("unsubscribe stateChange callback")
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
