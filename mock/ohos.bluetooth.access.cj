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

import ohos.business_exception.AsyncCallback
import ohos.callback_invoke.Callback1Argument
import ohos.labels.APILevel

import std.deriving.Derive

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
    return BluetoothState.StateOff
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
}
