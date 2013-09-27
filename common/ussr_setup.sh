#!/system/bin/sh

# Copyright (c) 2013, NVIDIA CORPORATION.  All rights reserved.
#
# NVIDIA CORPORATION and its licensors retain all intellectual property
# and proprietary rights in and to this software, related documentation
# and any modifications thereto.  Any use, reproduction, disclosure or
# distribution of this software and related documentation without an express
# license agreement from NVIDIA CORPORATION is strictly prohibited.

# set up power management nodes for user space control
chown system /sys/kernel/cluster/active
chmod 0640 /sys/kernel/cluster/active

# loop through all 4 cpu cores
ci=0
while [[ $ci -le 3 ]]
do
    chown system /sys/devices/system/cpu/cpu${ci}/cpuquiet/active
    chmod 0664 /sys/devices/system/cpu/cpu${ci}/cpuquiet/active

    chown system /sys/devices/system/cpu/cpu${ci}/cpufreq/scaling_governor
    chmod 0664 /sys/devices/system/cpu/cpu${ci}/cpufreq/scaling_governor

    chown system /sys/devices/system/cpu/cpu${ci}/cpufreq/scaling_setspeed
    chmod 0664 /sys/devices/system/cpu/cpu${ci}/cpufreq/scaling_setspeed

    (( ci++ ))
done

chown system /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
chmod 0444 /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
chown system /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
chmod 0444 /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
chown system /sys/devices/system/cpu/cpufreq/cpuload/cpu_load
chmod 0444 /sys/devices/system/cpu/cpufreq/cpuload/cpu_load
chown system /sys/devices/system/cpu/cpufreq/cpuload/enable
chmod 0664 /sys/devices/system/cpu/cpufreq/cpuload/enable
chown system /sys/devices/system/cpu/cpuquiet/tegra_cpuquiet/no_lp
chmod 0664 /sys/devices/system/cpu/cpuquiet/tegra_cpuquiet/no_lp
chown system /sys/devices/system/cpu/cpuquiet/tegra_cpuquiet/enable
chmod 0664 /sys/devices/system/cpu/cpuquiet/tegra_cpuquiet/enable
chown system /sys/devices/system/cpu/cpuquiet/current_governor
chmod 0664 /sys/devices/system/cpu/cpuquiet/current_governor
chown system /sys/devices/system/cpu/present
chmod 0444 /sys/devices/system/cpu/present
chown system /sys/kernel/debug/fps
chmod 0444 /sys/kernel/debug/fps
chown system /d/clock/cpu_g/min
chmod 0444 /d/clock/cpu_g/min
chown system /sys/kernel/debug/clock/c2bus/possible_rates
chmod 0444 /sys/kernel/debug/clock/c2bus/possible_rates
chown system /sys/devices/platform/host1x/gr3d/freq_request
chmod 0664 /sys/devices/platform/host1x/gr3d/freq_request
chown system /sys/devices/platform/host1x/gr3d/user
chmod 0664 /sys/devices/platform/host1x/gr3d/user
chown system /sys/devices/platform/host1x/gr3d/devfreq/gr3d/cur_freq
chmod 0444 /sys/devices/platform/host1x/gr3d/devfreq/gr3d/cur_freq
chown system /sys/kernel/debug/tegra_host/3d_actmon_avg_norm
chmod 0444 /sys/kernel/debug/tegra_host/3d_actmon_avg_norm
chown system /d/clock/cpu_lp/max
chmod 0644 /d/clock/cpu_lp/max

# loop through up to 10 possible thermal zones
tz=0
while [[ $tz -le 10 ]]
do
    chown system /sys/class/thermal/thermal_zone${tz}/type
    chmod 0444 /sys/class/thermal/thermal_zone${tz}/type
    chown system /sys/class/thermal/thermal_zone${tz}/temp
    chmod 0444 /sys/class/thermal/thermal_zone${tz}/temp

    # loop through up to 30 possible trip points per thermal zone
    tp=0
    while [[ $tp -le 30 ]]
    do
        chown system /sys/class/thermal/thermal_zone${tz}/trip_point_${tp}_temp
        chmod 0664 /sys/class/thermal/thermal_zone${tz}/trip_point_${tp}_temp
        (( tp++ ))
    done

    (( tz++ ))
done
