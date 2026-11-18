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

import ohos.bluetooth.getErrorMsg
import ohos.bluetooth.constant.{ MajorClass, MajorMinorClass }
import ohos.business_exception.BusinessException
import ohos.ffi.SUCCESS_CODE
import ohos.labels.APILevel

import std.collection.HashMap
import std.deriving.Derive

/**
 * Checks the FFI error code for the connection package.
 *
 * Unlike the shared checkRet, which normalizes 401 to 2900099, this helper
 * passes 401 through to align with the ArkTS runtime (decision D7-d).
 * 401 is not part of the declared @throws set; the behavior difference is
 * intentional and disclosed in the PR description.
 */
protected func checkRetKeep401(errorCode: Int32): Unit {
    if (errorCode != SUCCESS_CODE) {
        throw BusinessException(errorCode, getErrorMsg(errorCode))
    }
}

/**
 * Describes the class of a bluetooth device.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class BondStateParam {
    private var deviceIdImpl: String
    private var stateImpl: BondState
    private var causeImpl: UnbondCause

    init(deviceId: String, state: BondState, cause: UnbondCause) {
        this.deviceIdImpl = deviceId
        this.stateImpl = state
        this.causeImpl = cause
    }

    /**
     * Address of a Bluetooth device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public mut prop deviceId: String {
        get() {
            return deviceIdImpl
        }
        set(value) {
            deviceIdImpl = value
        }
    }

    /**
     * Profile connection state of the device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public mut prop state: BondState {
        get() {
            return stateImpl
        }
        set(value) {
            stateImpl = value
        }
    }

    /**
     * Cause of unbond.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public mut prop cause: UnbondCause {
        get() {
            return causeImpl
        }
        set(value) {
            causeImpl = value
        }
    }
}

/**
 * Describes the bond key param.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class PinRequiredParam {
    private var deviceIdImpl: String
    private var pinCodeImpl: String

    init(deviceId: String, pinCode: String) {
        this.deviceIdImpl = deviceId
        this.pinCodeImpl = pinCode
    }

    /**
     * ID of the device to pair.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public mut prop deviceId: String {
        get() {
            return deviceIdImpl
        }
        set(value) {
            deviceIdImpl = value
        }
    }

    /**
     * Key for the device pairing.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public mut prop pinCode: String {
        get() {
            return pinCodeImpl
        }
        set(value) {
            pinCodeImpl = value
        }
    }
}

/**
 * Describes the class of a bluetooth device.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class DeviceClass {
    private var majorClassImpl: MajorClass
    private var majorMinorClassImpl: MajorMinorClass
    private var classOfDeviceImpl: Int32

    init(majorClass: MajorClass, majorMinorClass: MajorMinorClass, classOfDevice: Int32) {
        this.majorClassImpl = majorClass
        this.majorMinorClassImpl = majorMinorClass
        this.classOfDeviceImpl = classOfDevice
    }

    /**
     * Major classes of Bluetooth devices.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public mut prop majorClass: MajorClass {
        get() {
            return majorClassImpl
        }
        set(value) {
            majorClassImpl = value
        }
    }

    /**
     * Major and minor classes of Bluetooth devices.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public mut prop majorMinorClass: MajorMinorClass {
        get() {
            return majorMinorClassImpl
        }
        set(value) {
            majorMinorClassImpl = value
        }
    }

    /**
     * Class of the device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public mut prop classOfDevice: Int32 {
        get() {
            return classOfDeviceImpl
        }
        set(value) {
            classOfDeviceImpl = value
        }
    }
}

/**
 * Describes the contents of the battery information.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class BatteryInfo {
    private var batteryLevelImpl: Int32
    private var leftEarBatteryLevelImpl: Int32
    private var leftEarChargeStateImpl: DeviceChargeState
    private var rightEarBatteryLevelImpl: Int32
    private var rightEarChargeStateImpl: DeviceChargeState
    private var boxBatteryLevelImpl: Int32
    private var boxChargeStateImpl: DeviceChargeState

    init(batteryLevel: Int32, leftEarBatteryLevel: Int32, leftEarChargeState: DeviceChargeState,
         rightEarBatteryLevel: Int32, rightEarChargeState: DeviceChargeState,
         boxBatteryLevel: Int32, boxChargeState: DeviceChargeState) {
        this.batteryLevelImpl = batteryLevel
        this.leftEarBatteryLevelImpl = leftEarBatteryLevel
        this.leftEarChargeStateImpl = leftEarChargeState
        this.rightEarBatteryLevelImpl = rightEarBatteryLevel
        this.rightEarChargeStateImpl = rightEarChargeState
        this.boxBatteryLevelImpl = boxBatteryLevel
        this.boxChargeStateImpl = boxChargeState
    }

    /**
     * Electricity value of the general device. {@code -1} means no power information.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public mut prop batteryLevel: Int32 {
        get() {
            return batteryLevelImpl
        }
        set(value) {
            batteryLevelImpl = value
        }
    }

    /**
     * Electricity value of the left ear. {@code -1} means no power information.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public mut prop leftEarBatteryLevel: Int32 {
        get() {
            return leftEarBatteryLevelImpl
        }
        set(value) {
            leftEarBatteryLevelImpl = value
        }
    }

    /**
     * The charge state of the left ear.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public mut prop leftEarChargeState: DeviceChargeState {
        get() {
            return leftEarChargeStateImpl
        }
        set(value) {
            leftEarChargeStateImpl = value
        }
    }

    /**
     * Electricity value of the right ear. {@code -1} means no power information.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public mut prop rightEarBatteryLevel: Int32 {
        get() {
            return rightEarBatteryLevelImpl
        }
        set(value) {
            rightEarBatteryLevelImpl = value
        }
    }

    /**
     * The charge state of the right ear.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public mut prop rightEarChargeState: DeviceChargeState {
        get() {
            return rightEarChargeStateImpl
        }
        set(value) {
            rightEarChargeStateImpl = value
        }
    }

    /**
     * Electricity value of the box. {@code -1} means no power information.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public mut prop boxBatteryLevel: Int32 {
        get() {
            return boxBatteryLevelImpl
        }
        set(value) {
            boxBatteryLevelImpl = value
        }
    }

    /**
     * The charge state of the box.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public mut prop boxChargeState: DeviceChargeState {
        get() {
            return boxChargeStateImpl
        }
        set(value) {
            boxChargeStateImpl = value
        }
    }
}

/**
 * The native bond state param, whose layout must be the same as the native CBondStateParam.
 * The payload is owned and released by the native side; only value copies are taken.
 */
@C
struct CBondStateParam {
    CBondStateParam(
        let deviceId: CString,
        let state: Int32,
        let cause: Int32
    ) {}

    func toObject(): ?BondStateParam {
        if (let Some(bondState) <- BondState.parse(state)) {
            if (let Some(unbondCause) <- UnbondCause.parse(cause)) {
                // D7-c: a null payload string maps to the empty string.
                let id = if (deviceId.isNull()) { "" } else { deviceId.toString() }
                return Some(BondStateParam(id, bondState, unbondCause))
            }
        }
        // D7-a: an unknown enum value makes the payload undeliverable; the
        // caller logs and drops the event instead of crossing the FFI border.
        None
    }
}

/**
 * The native pin required param, whose layout must be the same as the native CPinRequiredParam.
 * The payload is owned and released by the native side; only value copies are taken.
 */
@C
struct CPinRequiredParam {
    CPinRequiredParam(
        let deviceId: CString,
        let pinCode: CString
    ) {}

    func toObject(): PinRequiredParam {
        // D7-c: a null payload string maps to the empty string.
        let id = if (deviceId.isNull()) { "" } else { deviceId.toString() }
        let code = if (pinCode.isNull()) { "" } else { pinCode.toString() }
        PinRequiredParam(id, code)
    }
}

/**
 * The native device class, whose layout must be the same as the native DeviceClass.
 */
@C
struct CDeviceClass {
    CDeviceClass(
        let majorClass: Int32,
        let majorMinorClass: Int32,
        let classOfDevice: Int32
    ) {}

    func toObject(): DeviceClass {
        DeviceClass(parseMajorClass(majorClass), parseMajorMinorClass(majorMinorClass), classOfDevice)
    }
}

/**
 * The native battery info, whose layout must be the same as the native CBatteryInfo.
 */
@C
struct CBatteryInfo {
    CBatteryInfo(
        let batteryLevel: Int32,
        let leftEarBatteryLevel: Int32,
        let leftEarChargeState: Int32,
        let rightEarBatteryLevel: Int32,
        let rightEarChargeState: Int32,
        let boxBatteryLevel: Int32,
        let boxChargeState: Int32
    ) {}

    func toObject(): ?BatteryInfo {
        if (let Some(leftState) <- DeviceChargeState.parse(leftEarChargeState)) {
            if (let Some(rightState) <- DeviceChargeState.parse(rightEarChargeState)) {
                if (let Some(boxState) <- DeviceChargeState.parse(boxChargeState)) {
                    return Some(BatteryInfo(batteryLevel, leftEarBatteryLevel, leftState,
                        rightEarBatteryLevel, rightState, boxBatteryLevel, boxState))
                }
            }
        }
        // D7-a: see CBondStateParam.toObject.
        None
    }
}

/**
 * The enum of BR scan mode.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum ScanMode {
    /**
     * Indicates the scan mode is none.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ScanModeNone
    |
    /**
     * Indicates the scan mode is connectable.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ScanModeConnectable
    |
    /**
     * Indicates the scan mode is general discoverable.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ScanModeGeneralDiscoverable
    |
    /**
     * Indicates the scan mode is limited discoverable.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ScanModeLimitedDiscoverable
    |
    /**
     * Indicates the scan mode is connectable and general discoverable.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ScanModeConnectableGeneralDiscoverable
    |
    /**
     * Indicates the scan mode is connectable and limited discoverable.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ScanModeConnectableLimitedDiscoverable
    | ...

    /**
     * Parses the native scan mode value. Returns None for values outside the
     * declared range; callers apply the D7-a boundary rule.
     */
    protected static func parse(mode: Int32): ?ScanMode {
        match (mode) {
            case 0i32 => Some(ScanModeNone)
            case 1i32 => Some(ScanModeConnectable)
            case 2i32 => Some(ScanModeGeneralDiscoverable)
            case 3i32 => Some(ScanModeLimitedDiscoverable)
            case 4i32 => Some(ScanModeConnectableGeneralDiscoverable)
            case 5i32 => Some(ScanModeConnectableLimitedDiscoverable)
            case _ => None
        }
    }

    /**
     * Returns the native scan mode value; must stay in sync with the C++ scan mode enum.
     */
    protected func getValue(): Int32 {
        match (this) {
            case ScanModeNone => 0
            case ScanModeConnectable => 1
            case ScanModeGeneralDiscoverable => 2
            case ScanModeLimitedDiscoverable => 3
            case ScanModeConnectableGeneralDiscoverable => 4
            case ScanModeConnectableLimitedDiscoverable => 5
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}

/**
 * The enum of bond state.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum BondState {
    /**
     * Indicate the bond state is invalid.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    BondStateInvalid
    |
    /**
     * Indicate the bond state is bonding.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    BondStateBonding
    |
    /**
     * Indicate the bond state is bonded.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    BondStateBonded
    | ...

    /**
     * Parses the native bond state value. Returns None for values outside the
     * declared range; callers apply the D7-a boundary rule.
     */
    protected static func parse(state: Int32): ?BondState {
        match (state) {
            case 0i32 => Some(BondStateInvalid)
            case 1i32 => Some(BondStateBonding)
            case 2i32 => Some(BondStateBonded)
            case _ => None
        }
    }
}

/**
 * Enum for the charge state.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum DeviceChargeState {
    /**
     * Not support super charge, and not charged.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    DeviceNormalChargeNotCharged
    |
    /**
     * Not support super charge, and in charging.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    DeviceNormalChargeInCharging
    |
    /**
     * Support super charge, and not charged.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    DeviceSuperChargeNotCharged
    |
    /**
     * Support super charge, and in charging.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    DeviceSuperChargeInCharging
    | ...

    /**
     * Parses the native charge state value. Returns None for values outside the
     * declared range; callers apply the D7-a boundary rule.
     */
    protected static func parse(state: Int32): ?DeviceChargeState {
        match (state) {
            case 0i32 => Some(DeviceNormalChargeNotCharged)
            case 1i32 => Some(DeviceNormalChargeInCharging)
            case 2i32 => Some(DeviceSuperChargeNotCharged)
            case 3i32 => Some(DeviceSuperChargeInCharging)
            case _ => None
        }
    }
}

/**
 * Enum for cause of unbond.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum UnbondCause {
    /**
     * User proactively removed device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    UserRemoved
    |
    /**
     * Remote device shut down.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    RemoteDeviceDown
    |
    /**
     * Wrong PIN code.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AuthFailure
    |
    /**
     * Remote device rejected.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AuthRejected
    |
    /**
     * Internal error.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    InternalError
    | ...

    /**
     * Parses the native unbond cause value. Returns None for values outside the
     * declared range; callers apply the D7-a boundary rule.
     */
    protected static func parse(cause: Int32): ?UnbondCause {
        match (cause) {
            case 0i32 => Some(UserRemoved)
            case 1i32 => Some(RemoteDeviceDown)
            case 2i32 => Some(AuthFailure)
            case 3i32 => Some(AuthRejected)
            case 4i32 => Some(InternalError)
            case _ => None
        }
    }
}

// ---------------------------------------------------------------------------
// Class of Device (CoD) parse tables.
//
// D4-C decision (stage1_decision_summary §5.3.1), values verified against the
// Bluetooth Assigned Numbers minor-class layout:
// - 0x0500 maps to PeripheralUncategorized; PeripheralNonKeyboardNonPointing
//   shares the same CoD in the ArkTS numeric enum and is unreachable through
//   parse by design (symbolic enums must pick one label per key).
// - 0x05C0 maps to PeripheralKeyboardPointing (spec: keyboard+pointing bits).
// - 0x050C maps to PeripheralRemoteControl (spec remote control value; the
//   ArkTS d.ts assigns 0x05C0 to PERIPHERAL_REMOTE_CONTROL, a suspected
//   upstream digit transposition of 0x050C - intentional divergence,
//   disclosed in the PR description).
// ---------------------------------------------------------------------------
let MAJOR_CLASS_MAP = HashMap<Int32, MajorClass>(
    [
        (0x0000, MajorMisc),
        (0x0100, MajorComputer),
        (0x0200, MajorPhone),
        (0x0300, MajorNetworking),
        (0x0400, MajorAudioVideo),
        (0x0500, MajorPeripheral),
        (0x0600, MajorImaging),
        (0x0700, MajorWearable),
        (0x0800, MajorToy),
        (0x0900, MajorHealth),
        (0x1F00, MajorUncategorized)
    ]
)

let MAJOR_MINOR_CLASS_MAP = HashMap<Int32, MajorMinorClass>(
    [
        (0x0100, ComputerUncategorized),
        (0x0104, ComputerDesktop),
        (0x0108, ComputerServer),
        (0x010C, ComputerLaptop),
        (0x0110, ComputerHandheldPcPda),
        (0x0114, ComputerPalmSizePcPda),
        (0x0118, ComputerWearable),
        (0x011C, ComputerTablet),
        (0x0200, PhoneUncategorized),
        (0x0204, PhoneCellular),
        (0x0208, PhoneCordless),
        (0x020C, PhoneSmart),
        (0x0210, PhoneModemOrGateway),
        (0x0214, PhoneIsdn),
        (0x0300, NetworkFullyAvailable),
        (0x0320, Network1To17Utilized),
        (0x0340, Network17To33Utilized),
        (0x0360, Network33To50Utilized),
        (0x0380, Network60To67Utilized),
        (0x03A0, Network67To83Utilized),
        (0x03C0, Network83To99Utilized),
        (0x03E0, NetworkNoService),
        (0x0400, AudioVideoUncategorized),
        (0x0404, AudioVideoWearableHeadset),
        (0x0408, AudioVideoHandsfree),
        (0x0410, AudioVideoMicrophone),
        (0x0414, AudioVideoLoudspeaker),
        (0x0418, AudioVideoHeadphones),
        (0x041C, AudioVideoPortableAudio),
        (0x0420, AudioVideoCarAudio),
        (0x0424, AudioVideoSetTopBox),
        (0x0428, AudioVideoHifiAudio),
        (0x042C, AudioVideoVcr),
        (0x0430, AudioVideoVideoCamera),
        (0x0434, AudioVideoCamcorder),
        (0x0438, AudioVideoVideoMonitor),
        (0x043C, AudioVideoVideoDisplayAndLoudspeaker),
        (0x0440, AudioVideoVideoConferencing),
        (0x0448, AudioVideoVideoGamingToy),
        (0x0500, PeripheralUncategorized),
        (0x0504, PeripheralJoystick),
        (0x0508, PeripheralGamepad),
        (0x050C, PeripheralRemoteControl),
        (0x0510, PeripheralSensingDevice),
        (0x0514, PeripheralDigitizerTablet),
        (0x0518, PeripheralCardReader),
        (0x051C, PeripheralDigitalPen),
        (0x0520, PeripheralScannerRfid),
        (0x0522, PeripheralGesturalInput),
        (0x0540, PeripheralKeyboard),
        (0x0580, PeripheralPointingDevice),
        (0x05C0, PeripheralKeyboardPointing),
        (0x0600, ImagingUncategorized),
        (0x0610, ImagingDisplay),
        (0x0620, ImagingCamera),
        (0x0640, ImagingScanner),
        (0x0680, ImagingPrinter),
        (0x0700, WearableUncategorized),
        (0x0704, WearableWristWatch),
        (0x0708, WearablePager),
        (0x070C, WearableJacket),
        (0x0710, WearableHelmet),
        (0x0714, WearableGlasses),
        (0x0800, ToyUncategorized),
        (0x0804, ToyRobot),
        (0x0808, ToyVehicle),
        (0x080C, ToyDollActionFigure),
        (0x0810, ToyController),
        (0x0814, ToyGame),
        (0x0900, HealthUncategorized),
        (0x0904, HealthBloodPressure),
        (0x0908, HealthThermometer),
        (0x090C, HealthWeighing),
        (0x0910, HealthGlucose),
        (0x0914, HealthPulseOximeter),
        (0x0918, HealthPulseRate),
        (0x091C, HealthDataDisplay),
        (0x0920, HealthStepCounter),
        (0x0924, HealthBodyCompositionAnalyzer),
        (0x0928, HealthPeakFlowMonitor),
        (0x092C, HealthMedicationMonitor),
        (0x0930, HealthKneeProsthesis),
        (0x0934, HealthAnkleProsthesis),
        (0x0938, HealthGenericHealthManager),
        (0x093C, HealthPersonalMobilityDevice)
    ]
)

// Major-class degradation fallback for CoD values outside the parse table
// (D4 companion decision): unassigned minor bits are normal for an open value
// domain, so degrade to the base member of the major class. Networking has no
// Uncategorized member; its base value NetworkFullyAvailable is used.
// Correction to the decision wording: MajorUncategorized is a MajorClass
// member and does not exist in MajorMinorClass, so unknown major classes
// finally degrade to ComputerUncategorized (the compat convention).
let MAJOR_MINOR_FALLBACK_MAP = HashMap<Int32, MajorMinorClass>(
    [
        (0x0100, ComputerUncategorized),
        (0x0200, PhoneUncategorized),
        (0x0300, NetworkFullyAvailable),
        (0x0400, AudioVideoUncategorized),
        (0x0500, PeripheralUncategorized),
        (0x0600, ImagingUncategorized),
        (0x0700, WearableUncategorized),
        (0x0800, ToyUncategorized),
        (0x0900, HealthUncategorized)
    ]
)

protected func parseMajorClass(majorClass: Int32): MajorClass {
    if (MAJOR_CLASS_MAP.contains(majorClass)) {
        return MAJOR_CLASS_MAP[majorClass]
    }
    MajorUncategorized
}

protected func parseMajorMinorClass(majorMinorClass: Int32): MajorMinorClass {
    if (MAJOR_MINOR_CLASS_MAP.contains(majorMinorClass)) {
        return MAJOR_MINOR_CLASS_MAP[majorMinorClass]
    }
    let major = majorMinorClass & 0x1F00
    if (MAJOR_MINOR_FALLBACK_MAP.contains(major)) {
        return MAJOR_MINOR_FALLBACK_MAP[major]
    }
    ComputerUncategorized
}
