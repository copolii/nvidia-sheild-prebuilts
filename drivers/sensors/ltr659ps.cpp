/*
 * Copyright (C) 2012 The Android Open Source Project
 *
 * Copyright (c) 2013-2014 NVIDIA CORPORATION. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <fcntl.h>
#include <cutils/log.h>
#include <stdlib.h>
#include <linux/input.h>
#include <hardware/sensors.h>

#include "ltr659ps.h"
#include "SensorUtil.h"

/*****************************************************************************/

#define LTR659PS_SYS_PATH "/sys/bus/iio/devices/iio:device1/distance"
#define LTR659PS_SYS_ENABLE_PATH "/sys/bus/iio/devices/iio:device1/enable"

ltr659ps::ltr659ps(const char *sysPath, const char *sysEnablePath,
                       unsigned int ProxThreshold)
    : SensorBase(NULL, NULL),
      mEnabled(0),
      mHasPendingEvent(false),
      mAlready_warned(false),
      mLast_value(-1),
      mSysPath(sysPath),
      mSysEnablePath(sysEnablePath),
      mProximityThreshold(ProxThreshold)
{
}

ltr659ps::ltr659ps()
    : SensorBase(NULL, NULL),
      mEnabled(0),
      mHasPendingEvent(false),
      mAlready_warned(false),
      mLast_value(-1)
{
    mSysPath = LTR659PS_SYS_PATH;
    mSysEnablePath = LTR659PS_SYS_ENABLE_PATH;
}


ltr659ps::~ltr659ps() {
}

int ltr659ps::enable(int32_t handle, int en) {
    int err = writeIntToFile(mSysEnablePath, en);
    if (err <= 0)
        return err;

    if (en != 0) {
        mLast_value = -1;
        mEnabled = true;
        mPollingDelay = MAX_POLLING_DELAY;
        mLastns.timestamp = 0;
    }
    else
       mEnabled = false;
    return 0;
}

int ltr659ps::setDelay(int32_t handle, int64_t ns) {
    mPollingDelay = ns;
    return 0;
}

bool ltr659ps::hasPendingEvents() const {
    if(mEnabled)
        return true;
    else
        return false;
}

int ltr659ps::readEvents(sensors_event_t* data, int count) {
    unsigned int value = 0;
    sensors_event_t Currentns;
    int64_t Delay;

    if (count < 1 || data == NULL || !mEnabled)
        return 0;

    Currentns.timestamp = getTimestamp();
    Delay = Currentns.timestamp - mLastns.timestamp;
    if (Delay < mPollingDelay)
        return 0;
    else
        mLastns.timestamp = Currentns.timestamp;

    int amt = readIntFromFile(mSysPath, &value);
    if (amt <= 0 && mAlready_warned == false) {
        ALOGE("ProximitySensor: read from %s failed", mSysPath);
        mAlready_warned = true;
        return 0;
    }

    if (((float)value) == mLast_value)
        return 0;

    (*data).version = sizeof(sensors_event_t);
    (*data).sensor = ID_P;
    (*data).type = SENSOR_TYPE_PROXIMITY;
    if (value == 0)
        (*data).distance = 3.0f;
    else
        (*data).distance = 0.0f;
    (*data).timestamp = Currentns.timestamp;
    mLast_value = value;
    ALOGV("ProximitySensor: value is %i", (int)value );
    return 1;
}
