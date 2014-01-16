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

#ifndef ANDROID_LTR659PS_H
#define ANDROID_LTR659PS_H

#include "sensors.h"
#include "SensorBase.h"


#define LTR_659PS_DEF {            \
    "Lite On Technology Corp LTR-659 Proximity sensor",     \
    "Lite-On Technology",                               \
    1, ID_P,                                \
    SENSOR_TYPE_PROXIMITY, 1.0f, 1.0f,        \
    0.25f, 0, 0, 0, { } }

#define MAX_POLLING_DELAY 2000000000


class ltr659ps : public SensorBase {
    bool mEnabled;
    bool mHasPendingEvent;
    bool mAlready_warned;
    float mLast_value;
    const char *mSysPath;
    const char *mSysEnablePath;
    int sid;
    unsigned int mProximityThreshold;
    int64_t mPollingDelay;
    sensors_event_t mLastns;

public:
    ltr659ps(const char *sysPath, const char *sysEnablePath,
        unsigned int ProxThreshold);
    ltr659ps();

    virtual ~ltr659ps();
    virtual int readEvents(sensors_event_t* data, int count);
    virtual bool hasPendingEvents() const;
    virtual int enable(int32_t handle, int enabled);
    virtual int setDelay(int32_t handle, int64_t ns);
};

#endif  // ANDROID_LTR659PS_H

