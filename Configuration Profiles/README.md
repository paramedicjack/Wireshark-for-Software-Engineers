# Configuration Profiles

Configuration Profiles allow you to export and import all of your custom filters, buttons, macros, colorizations, and more to different installations. Configuration profiles are extremely useful in team environments or for post capture analysis.

## Creating a Configuration Profile

1. Go to `Edit->Configuration Profiles`
2. Click the `+` button to create a new profile and name it
3. Select the profile and hit `OK`

Now, you'll be on a completely default configuration profile. 

Alternatively you can use the two square copy button to copy an existing profile.

## Import a Configuration Profile

1. Go to `Edit->Configuration Profiles`
2. Click the `Import` button and select `from zip` (or `from directory` if you unpacked it)
3. Select the profile and hit `OK`

Try this

[Sample Configuration Profile](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Configuration%20Profiles/sample_configuration_profiles/sample1.zip "Sample Configuration Profile")

on this

[Sample Packet Capture](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Configuration%20Profiles/sample_captures/Packets.cap "Sample Packet Capture")

and it should look like this

![alt text](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Configuration%20Profiles/photos/sample1.PNG?raw=true)

without any extra configuration. Check out the filters, macros, and buttons included in this Configuration Profile.

## Export a Configuration Profile

1. Go to `Edit->Configuration Profiles`
2. Click the `Export` button and choose a name
3. Select the profile and hit `OK`

## What does a Configuration Profile Include?

* filters 
* filter buttons
* filter macros
* layouts
* custom column setups
* disabled protocols
* time format

## What does a Configuration Profile not Include?

* dissectors
* captures
