/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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

package ohos.bluetooth.constant

import std.deriving.Derive
import ohos.labels.APILevel

/**
 * The enum of profile connection state.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum ProfileConnectionState {
    /**
     * the current profile is disconnected
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StateDisconnected
    |
    /**
     * the current profile is being connected
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StateConnecting
    |
    /**
     * the current profile is connected
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StateConnected
    |
    /**
     * the current profile is being disconnected
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StateDisconnecting
    | ...

    /**
     * @throws NoneValueException - Value conversion failed.
     */
    protected static func parse(state: Int32): ProfileConnectionState {
        match (state) {
            case 0i32 => StateDisconnected
            case 1i32 => StateConnecting
            case 2i32 => StateConnected
            case 3i32 => StateDisconnecting
            case _ => throw NoneValueException("Value does not exist!")
        }
    }
}

/**
 * The enum of profile id.
 */
@Derive[Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum ProfileId {
    /**
     * A2DP profile.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ProfileA2dpSource
    |
    /**
     * HFP profile.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ProfileHandsfreeAudioGateway
    |
    /**
     * Human Interface Device (HID) profile.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ProfileHidHost
    |
    /**
     * PAN profile.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ProfilePanNetwork
    | ...

    /**
     * Returns the profile id integer for the FFI boundary.
     * Note: the values must stay in sync with the C++ GetProfileId switch
     * (napi_bluetooth_utils.cpp); ProfilePanNetwork(7) relies on the PAN case there.
     */
    protected func getValue(): Int32 {
        match (this) {
            case ProfileA2dpSource => 1i32
            case ProfileHandsfreeAudioGateway => 4i32
            case ProfileHidHost => 6i32
            case ProfilePanNetwork => 7i32
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}

/**
 * Th
/**
 * Converts the ProfileId to its string representation: the member name, per the
 * interface analysis convention (the derived qualified "ProfileId.ProfileA2dpSource"
 * does not satisfy the declared contract; T002 finding I1).
 */
extend ProfileId <: ToString {
    /**
     * Converts the ProfileId to its string representation.
     * @returns { String } A string representation of the ProfileId.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func toString(): String {
        match (this) {
            case ProfileA2dpSource => "ProfileA2dpSource"
            case ProfileHandsfreeAudioGateway => "ProfileHandsfreeAudioGateway"
            case ProfileHidHost => "ProfileHidHost"
            case ProfilePanNetwork => "ProfilePanNetwork"
            // The declaration marks these enums open ("| ..." in the SDK
            // surface), so a wildcard arm is required; declared members are
            // all enumerated above and never reach it.
            case _ => ""
        }
    }
}
e enum of major class of a bluetooth device.
 */
@Derive[Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum MajorClass {
    /**
     * Miscellaneous device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    MajorMisc
    |
    /**
     * Computer.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    MajorComputer
    |
    /**
     * Mobile phone.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    MajorPhone
    |
    /**
     * Network device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    MajorNetworking
    |
    /**
     * Audio or video device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    MajorAudioVideo
    |
    /**
     * Peripheral device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    MajorPeripheral
    |
    /**
     * Imaging device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    MajorImaging
    |
    /**
     * Wearable device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    MajorWearable
    |
    /**
     * Toy.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    MajorToy
    |
    /**
     * Health device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    MajorHealth
    |
    /**
     * Unclassified device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    MajorUncategorized
    | ...
}

/**
 * Th
/**
 * Converts the MajorClass to its string representation: the member name, per the
 * interface analysis convention (the derived qualified "MajorClass.MajorMisc"
 * does not satisfy the declared contract; T002 finding I1).
 */
extend MajorClass <: ToString {
    /**
     * Converts the MajorClass to its string representation.
     * @returns { String } A string representation of the MajorClass.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func toString(): String {
        match (this) {
            case MajorMisc => "MajorMisc"
            case MajorComputer => "MajorComputer"
            case MajorPhone => "MajorPhone"
            case MajorNetworking => "MajorNetworking"
            case MajorAudioVideo => "MajorAudioVideo"
            case MajorPeripheral => "MajorPeripheral"
            case MajorImaging => "MajorImaging"
            case MajorWearable => "MajorWearable"
            case MajorToy => "MajorToy"
            case MajorHealth => "MajorHealth"
            case MajorUncategorized => "MajorUncategorized"
            // The declaration marks these enums open ("| ..." in the SDK
            // surface), so a wildcard arm is required; declared members are
            // all enumerated above and never reach it.
            case _ => ""
        }
    }
}
e enum of major minor class of a bluetooth device.
 */
@Derive[Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum MajorMinorClass {
    /**
     * The Minor Device Class field Computer Major Class
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ComputerUncategorized
    |
    /**
     * Desktop computer.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ComputerDesktop
    |
    /**
     * Server.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ComputerServer
    |
    /**
     * Laptop.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ComputerLaptop
    |
    /**
     * Hand-held computer.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ComputerHandheldPcPda
    |
    /**
     * Palmtop computer.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ComputerPalmSizePcPda
    |
    /**
     * Wearable computer.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ComputerWearable
    |
    /**
     * Tablet.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ComputerTablet
    |
    /**
     * Phone Major Class
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PhoneUncategorized
    |
    /**
     * Portable phone.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PhoneCellular
    |
    /**
     * Cordless phone.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PhoneCordless
    |
    /**
     * Smartphone.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PhoneSmart
    |
    /**
     * Modem or gateway phone.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PhoneModemOrGateway
    |
    /**
     * ISDN phone.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PhoneIsdn
    |
    /**
     * LAN/Network Access Point Major Class
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    NetworkFullyAvailable
    |
    /**
     * Device used on network 1 to 17.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    Network1To17Utilized
    |
    /**
     * Device used on network 17 to 33.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    Network17To33Utilized
    |
    /**
     * Device used on network 33 to 50.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    Network33To50Utilized
    |
    /**
     * Device used on network 60 to 67.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    Network60To67Utilized
    |
    /**
     * Device used on network 67 to 83.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    Network67To83Utilized
    |
    /**
     * Device used on network 83 to 99.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    Network83To99Utilized
    |
    /**
     * Device without network service.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    NetworkNoService
    |
    /**
     * Unclassified audio or video device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoUncategorized
    |
    /**
     * Wearable audio or video headset.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoWearableHeadset
    |
    /**
     * Hands-free audio or video device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoHandsfree
    |
    /**
     * Audio or video microphone.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoMicrophone
    |
    /**
     * Audio or video loudspeaker.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoLoudspeaker
    |
    /**
     * Audio or video headphones.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoHeadphones
    |
    /**
     * Portable audio or video device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoPortableAudio
    |
    /**
     * In-vehicle audio or video device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoCarAudio
    |
    /**
     * Audio or video STB device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoSetTopBox
    |
    /**
     * High-fidelity speaker device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoHifiAudio
    |
    /**
     * Video cassette recording (VCR) device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoVcr
    |
    /**
     * Camera.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoVideoCamera
    |
    /**
     * Camcorder.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoCamcorder
    |
    /**
     * Audio or video monitor.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoVideoMonitor
    |
    /**
     * Video display or loudspeaker.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoVideoDisplayAndLoudspeaker
    |
    /**
     * Video conferencing device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoVideoConferencing
    |
    /**
     * Audio or video gaming toy.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoVideoGamingToy
    |
    /**
     * Peripheral Major Class
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PeripheralNonKeyboardNonPointing
    |
    /**
     * Keyboard device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PeripheralKeyboard
    |
    /**
     * Pointing peripheral device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PeripheralPointingDevice
    |
    /**
     * Keyboard pointing device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PeripheralKeyboardPointing
    |
    /**
     * Unclassified peripheral device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PeripheralUncategorized
    |
    /**
     * Peripheral joystick.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PeripheralJoystick
    |
    /**
     * Peripheral game pad.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PeripheralGamepad
    |
    /**
     * Peripheral remote control device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PeripheralRemoteControl
    |
    /**
     * Peripheral sensing device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PeripheralSensingDevice
    |
    /**
     * Peripheral digitizer tablet.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PeripheralDigitizerTablet
    |
    /**
     * Peripheral card reader.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PeripheralCardReader
    |
    /**
     * Peripheral digital pen.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PeripheralDigitalPen
    |
    /**
     * Peripheral RFID scanner.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PeripheralScannerRfid
    |
    /**
     * Gesture input device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PeripheralGesturalInput
    |
    /**
     * Imaging Major Class
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ImagingUncategorized
    |
    /**
     * Imaging display device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ImagingDisplay
    |
    /**
     * Imaging camera device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ImagingCamera
    |
    /**
     * Imaging scanner.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ImagingScanner
    |
    /**
     * Imaging printer.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ImagingPrinter
    |
    /**
     * Wearable Major Class
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    WearableUncategorized
    |
    /**
     * Smart watch.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    WearableWristWatch
    |
    /**
     * Wearable pager.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    WearablePager
    |
    /**
     * Smart jacket.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    WearableJacket
    |
    /**
     * Wearable helmet.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    WearableHelmet
    |
    /**
     * Wearable glasses.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    WearableGlasses
    |
    /**
     * Minor Device Class field - Toy Major Class
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ToyUncategorized
    |
    /**
     * Toy robot.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ToyRobot
    |
    /**
     * Toy vehicle.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ToyVehicle
    |
    /**
     * Humanoid toy doll.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ToyDollActionFigure
    |
    /**
     * Toy controller.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ToyController
    |
    /**
     * Toy gaming device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ToyGame
    |
    /**
     * Minor Device Class field - Health
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    HealthUncategorized
    |
    /**
     * Blood pressure device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    HealthBloodPressure
    |
    /**
     * Thermometer.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    HealthThermometer
    |
    /**
     * Body scale.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    HealthWeighing
    |
    /**
     * Blood glucose monitor.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    HealthGlucose
    |
    /**
     * Pulse oximeter.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    HealthPulseOximeter
    |
    /**
     * Heart rate monitor.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    HealthPulseRate
    |
    /**
     * Health data display.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    HealthDataDisplay
    |
    /**
     * Step counter.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    HealthStepCounter
    |
    /**
     * Body composition analyzer.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    HealthBodyCompositionAnalyzer
    |
    /**
     * Hygrometer.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    HealthPeakFlowMonitor
    |
    /**
     * Medication monitor.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    HealthMedicationMonitor
    |
    /**
     * Prosthetic knee.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    HealthKneeProsthesis
    |
    /**
     * Prosthetic ankle.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    HealthAnkleProsthesis
    |
    /**
     * Generic health management device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    HealthGenericHealthManager
    |
    /**
     * Personal mobility device.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    HealthPersonalMobilityDevice
    | ...
}

/**
 * Converts the MajorMinorClass to its string representation: the member name, per the
 * interface analysis convention (the derived qualified "MajorMinorClass.ComputerUncategorized"
 * does not satisfy the declared contract; T002 finding I1).
 */
extend MajorMinorClass <: ToString {
    /**
     * Converts the MajorMinorClass to its string representation.
     * @returns { String } A string representation of the MajorMinorClass.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func toString(): String {
        match (this) {
            case ComputerUncategorized => "ComputerUncategorized"
            case ComputerDesktop => "ComputerDesktop"
            case ComputerServer => "ComputerServer"
            case ComputerLaptop => "ComputerLaptop"
            case ComputerHandheldPcPda => "ComputerHandheldPcPda"
            case ComputerPalmSizePcPda => "ComputerPalmSizePcPda"
            case ComputerWearable => "ComputerWearable"
            case ComputerTablet => "ComputerTablet"
            case PhoneUncategorized => "PhoneUncategorized"
            case PhoneCellular => "PhoneCellular"
            case PhoneCordless => "PhoneCordless"
            case PhoneSmart => "PhoneSmart"
            case PhoneModemOrGateway => "PhoneModemOrGateway"
            case PhoneIsdn => "PhoneIsdn"
            case NetworkFullyAvailable => "NetworkFullyAvailable"
            case Network1To17Utilized => "Network1To17Utilized"
            case Network17To33Utilized => "Network17To33Utilized"
            case Network33To50Utilized => "Network33To50Utilized"
            case Network60To67Utilized => "Network60To67Utilized"
            case Network67To83Utilized => "Network67To83Utilized"
            case Network83To99Utilized => "Network83To99Utilized"
            case NetworkNoService => "NetworkNoService"
            case AudioVideoUncategorized => "AudioVideoUncategorized"
            case AudioVideoWearableHeadset => "AudioVideoWearableHeadset"
            case AudioVideoHandsfree => "AudioVideoHandsfree"
            case AudioVideoMicrophone => "AudioVideoMicrophone"
            case AudioVideoLoudspeaker => "AudioVideoLoudspeaker"
            case AudioVideoHeadphones => "AudioVideoHeadphones"
            case AudioVideoPortableAudio => "AudioVideoPortableAudio"
            case AudioVideoCarAudio => "AudioVideoCarAudio"
            case AudioVideoSetTopBox => "AudioVideoSetTopBox"
            case AudioVideoHifiAudio => "AudioVideoHifiAudio"
            case AudioVideoVcr => "AudioVideoVcr"
            case AudioVideoVideoCamera => "AudioVideoVideoCamera"
            case AudioVideoCamcorder => "AudioVideoCamcorder"
            case AudioVideoVideoMonitor => "AudioVideoVideoMonitor"
            case AudioVideoVideoDisplayAndLoudspeaker => "AudioVideoVideoDisplayAndLoudspeaker"
            case AudioVideoVideoConferencing => "AudioVideoVideoConferencing"
            case AudioVideoVideoGamingToy => "AudioVideoVideoGamingToy"
            case PeripheralNonKeyboardNonPointing => "PeripheralNonKeyboardNonPointing"
            case PeripheralKeyboard => "PeripheralKeyboard"
            case PeripheralPointingDevice => "PeripheralPointingDevice"
            case PeripheralKeyboardPointing => "PeripheralKeyboardPointing"
            case PeripheralUncategorized => "PeripheralUncategorized"
            case PeripheralJoystick => "PeripheralJoystick"
            case PeripheralGamepad => "PeripheralGamepad"
            case PeripheralRemoteControl => "PeripheralRemoteControl"
            case PeripheralSensingDevice => "PeripheralSensingDevice"
            case PeripheralDigitizerTablet => "PeripheralDigitizerTablet"
            case PeripheralCardReader => "PeripheralCardReader"
            case PeripheralDigitalPen => "PeripheralDigitalPen"
            case PeripheralScannerRfid => "PeripheralScannerRfid"
            case PeripheralGesturalInput => "PeripheralGesturalInput"
            case ImagingUncategorized => "ImagingUncategorized"
            case ImagingDisplay => "ImagingDisplay"
            case ImagingCamera => "ImagingCamera"
            case ImagingScanner => "ImagingScanner"
            case ImagingPrinter => "ImagingPrinter"
            case WearableUncategorized => "WearableUncategorized"
            case WearableWristWatch => "WearableWristWatch"
            case WearablePager => "WearablePager"
            case WearableJacket => "WearableJacket"
            case WearableHelmet => "WearableHelmet"
            case WearableGlasses => "WearableGlasses"
            case ToyUncategorized => "ToyUncategorized"
            case ToyRobot => "ToyRobot"
            case ToyVehicle => "ToyVehicle"
            case ToyDollActionFigure => "ToyDollActionFigure"
            case ToyController => "ToyController"
            case ToyGame => "ToyGame"
            case HealthUncategorized => "HealthUncategorized"
            case HealthBloodPressure => "HealthBloodPressure"
            case HealthThermometer => "HealthThermometer"
            case HealthWeighing => "HealthWeighing"
            case HealthGlucose => "HealthGlucose"
            case HealthPulseOximeter => "HealthPulseOximeter"
            case HealthPulseRate => "HealthPulseRate"
            case HealthDataDisplay => "HealthDataDisplay"
            case HealthStepCounter => "HealthStepCounter"
            case HealthBodyCompositionAnalyzer => "HealthBodyCompositionAnalyzer"
            case HealthPeakFlowMonitor => "HealthPeakFlowMonitor"
            case HealthMedicationMonitor => "HealthMedicationMonitor"
            case HealthKneeProsthesis => "HealthKneeProsthesis"
            case HealthAnkleProsthesis => "HealthAnkleProsthesis"
            case HealthGenericHealthManager => "HealthGenericHealthManager"
            case HealthPersonalMobilityDevice => "HealthPersonalMobilityDevice"
            // The declaration marks these enums open ("| ..." in the SDK
            // surface), so a wildcard arm is required; declared members are
            // all enumerated above and never reach it.
            case _ => ""
        }
    }
}
