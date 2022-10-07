# Filters

## What are filters?

Filters allow you to isolate the wireshark traffic that you want to see. Filters are one of the most important tools in Wireshark and you will likely use a filter every time you analyze a capture. Filters can be applied to 
* Protocol (UDP, TCP, ARP, etc)
* Length
* IP source and destination
* Ports

and more. In this tutorial we will be exploring some ways to use, create, and combine filters.

Please download the following sample capture file

[Packets.cap](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Filters/sample_captures/Packets.cap "Packets")

and open it in wireshark. 

## Copying a filter

Filters can be copied from most of the columns in the `Packet List` panel or any of the fields in the `Packet Details` panel. Simply right click and select `Apply as Filter->Selected`

TODO: IMAGE

You can also copy the filter to your clipboard without applying it by right clicking and selecting `Copy->As Filter`

## Bookmarking a filter

Bookmarking filters is important if you find yourself using the same filter often. 

1. Click the Bookmark Icon in the top left corner
2. Click `Save this filter`
3. In the new window, change the `New display filter` to any name
4. Select `Ok`

Now that this filter has been created you can access it by clicking the bookmark icon and selecting it from the dropdown. I recommend deleting the other wireshark preset bookmarks. 

## Filter buttons

Filter buttons are similar to filter bookmarks but are quicker and easier to press.

1. Click the Bookmark Icon in the top left corner
2. Click `Filter Button Preferences...`
3. Press the `+` icon to create a new filter button
4. Mark the show in checkbox option
5. Choose a `Label` - this will be the name of the button in your toolbar
6. Enter your `Filter Expression`

I created a filter button for UDP packets called `long udp` with the filter expression `ip.proto == udp and frame.len > 200`

![alt text](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Filters/photos/buttons1.PNG?raw=true)
![alt text](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Filters/photos/buttons2.PNG?raw=true)

## Filter macro

Similar to macros in programming languages, macros allow you to create a shorthand for a filter.

### Creating a macro

1. Click `Analyze->Display Filter Macros...` from the toolbar
2. Choose a `Name` for your macro - this will be the shorthand which you use to reference it later
3. Enter the filter in the `Text`

I created a macro for long udp packets called `lu` and one for short udp packets called `su`

![alt text](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Filters/photos/macros3.PNG?raw=true)


### Using a macro

The syntax for a macro is `${[macro name]}`.
For example, `${su}` will act as a substitution for our macro `ip.proto == udp and frame.len < 200`

![alt text](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Filters/photos/macros1.PNG?raw=true)

We can also use macros as a substitution in our `Filter buttons` and `Filter bookmarks`

![alt text](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Filters/photos/macros2.PNG?raw=true)

### Variable macros

Filter macros can also take variables. Variables come in the form of `$[number]` and can be referenced in a list separated by semicolons in the format `${[macro_name]:[variable1];[variable2];...}`

I've created a variable macro called `protolt` with the expression `ip.proto == $1 and frame.len < $2` where `$1` is the protocol and `$2` is the largest filtered length

![alt text](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Filters/photos/macros3.PNG)

Here's how you call it `${protolt:udp;61}`

![alt text](https://github.com/paramedicjack/Wireshark-for-Software-Engineers/blob/main/Filters/photos/macros4.PNG)

## Building filter expressions

### Logic

Filter expressions use similar logic to programming languages such as `eq (==)`, `gt (>)`, and `le (<=)`. Here are some filter expressions you can try out with our dataset

* `ip.src == 10.0.0.10`
* `udp.dstport >= 40000`
* `udp.srcport != 50000`

Additionally, `contains` will determine if a protocol or slice contains values and `match` will filter packets with perl-compatible regex. Try these filter expressions out with our dataset.

* `udp contains 20:0d:0a:32`

TODO: more examples

You can also use in `in` for some filter expressions to replace multiple `==`, like `udp.dstport in { 40000, 50000, 50500 }`

### Combining expressions

You can use logical `and (&&)`, `or (||)`, `not (!)`, and more to create combined expressions. Here are some combined filters we can use to produce subsets of our data

* `ip.src == 10.0.0.10 and ip.proto == udp and frame.len >= 150`
* `frame.len >= 150 and udp contains 20:0d:0a:32`

## Exercises

Create a UDP filter for IP sources `10.0.0.10, 10.0.0.11, ... 10.0.0.19` with destination ports `40000...50000`

<details><summary>Possible solution</summary>
    <pre>
    ip.src >= 10.0.0.10 and ip.src <= 10.0.0.19 and udp.dstport >= 40000 and udp.dstport <= 50000
    </pre>
    note: the presence of the udp.dstport filter gets rid of other traffic so we don't need a separate udp filter
</details>

Create multiple macros and use them to create a combined filter

<details><summary>Possible solution</summary>
    <pre>
    $long frame.len > 200
    $iprange ip.src >= 10.0.0.10 and ip.src <= 10.0.0.19
    ${long} and !(${iprange})
    </pre>
</details>

Create and use a UDP filter macro that takes two IP addresses (source and destination) and two integers to act as the frame length range

<details><summary>Possible solution</summary>
    <pre>
    $udprange udp.srcport == $1 and udp.dstport == $2 and frame.len >= $3 and frame.len <= $4
    ${udprange:10.0.0.10;10.0.20;50;75}
    </pre>
</details>

## References

[Wireshark filters documentation](https://www.wireshark.org/docs/wsug_html_chunked/ChWorkBuildDisplayFilterSection.html "Wireshark filters documentation")
