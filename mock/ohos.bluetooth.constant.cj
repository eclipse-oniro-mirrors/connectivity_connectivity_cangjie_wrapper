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

package ohos.bluetooth.constant

import ohos.labels.APILevel

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum ProfileConnectionState {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StateDisconnected
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StateConnecting
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StateConnected
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StateDisconnecting
    | ...
}

extend ProfileConnectionState <: ToString {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func toString(): String {
        return String()
    }
}

extend ProfileConnectionState <: Equatable<ProfileConnectionState> {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public operator func ==(other: ProfileConnectionState): Bool {
        return true
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public operator func !=(other: ProfileConnectionState): Bool {
        return true
    }
}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum ProfileId {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ProfileA2dpSource
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ProfileHandsfreeAudioGateway
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ProfileHidHost
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ProfilePanNetwork
    | ...
}

extend ProfileId <: ToString {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func toString(): String {
        return String()
    }
}

extend ProfileId <: Equatable<ProfileId> {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public operator func ==(other: ProfileId): Bool {
        return true
    }

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public operator func !=(other: ProfileId): Bool {
        return true
    }
}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum MajorClass {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    MajorMisc
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    MajorComputer
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    MajorPhone
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    MajorNetworking
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    MajorAudioVideo
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    MajorPeripheral
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    MajorImaging
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    MajorWearable
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    MajorToy
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    MajorHealth
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    MajorUncategorized
    | ...
}

extend MajorClass <: ToString {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func toString(): String {
        return String()
    }
}

extend MajorClass <: Equatable<MajorClass> {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public operator func ==(other: MajorClass): Bool {
        return true
    }

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public operator func !=(other: MajorClass): Bool {
        return true
    }
}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum MajorMinorClass {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ComputerUncategorized
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ComputerDesktop
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ComputerServer
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ComputerLaptop
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ComputerHandheldPcPda
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ComputerPalmSizePcPda
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ComputerWearable
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ComputerTablet
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PhoneUncategorized
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PhoneCellular
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PhoneCordless
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PhoneSmart
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PhoneModemOrGateway
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PhoneIsdn
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    NetworkFullyAvailable
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    Network1To17Utilized
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    Network17To33Utilized
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    Network33To50Utilized
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    Network60To67Utilized
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    Network67To83Utilized
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    Network83To99Utilized
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    NetworkNoService
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoUncategorized
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoWearableHeadset
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoHandsfree
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoMicrophone
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoLoudspeaker
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoHeadphones
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoPortableAudio
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoCarAudio
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoSetTopBox
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoHifiAudio
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoVcr
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoVideoCamera
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoCamcorder
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoVideoMonitor
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoVideoDisplayAndLoudspeaker
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoVideoConferencing
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AudioVideoVideoGamingToy
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PeripheralNonKeyboardNonPointing
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PeripheralKeyboard
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PeripheralPointingDevice
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PeripheralKeyboardPointing
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PeripheralUncategorized
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PeripheralJoystick
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PeripheralGamepad
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PeripheralRemoteControl
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PeripheralSensingDevice
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PeripheralDigitizerTablet
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PeripheralCardReader
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PeripheralDigitalPen
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PeripheralScannerRfid
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PeripheralGesturalInput
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ImagingUncategorized
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ImagingDisplay
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ImagingCamera
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ImagingScanner
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ImagingPrinter
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    WearableUncategorized
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    WearableWristWatch
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    WearablePager
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    WearableJacket
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    WearableHelmet
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    WearableGlasses
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ToyUncategorized
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ToyRobot
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ToyVehicle
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ToyDollActionFigure
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ToyController
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ToyGame
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    HealthUncategorized
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    HealthBloodPressure
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    HealthThermometer
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    HealthWeighing
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    HealthGlucose
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    HealthPulseOximeter
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    HealthPulseRate
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    HealthDataDisplay
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    HealthStepCounter
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    HealthBodyCompositionAnalyzer
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    HealthPeakFlowMonitor
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    HealthMedicationMonitor
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    HealthKneeProsthesis
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    HealthAnkleProsthesis
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    HealthGenericHealthManager
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    HealthPersonalMobilityDevice
    | ...
}

extend MajorMinorClass <: ToString {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func toString(): String {
        return String()
    }
}

extend MajorMinorClass <: Equatable<MajorMinorClass> {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public operator func ==(other: MajorMinorClass): Bool {
        return true
    }

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public operator func !=(other: MajorMinorClass): Bool {
        return true
    }
}
