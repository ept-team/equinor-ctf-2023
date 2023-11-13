# Bouncyball
Writeup by Nikolas Papaioannou aka n0k0


Short demo video for those unable to run the challenge:  
https://www.youtube.com/watch?v=sABfHVuYVuE


"Web is shady" -> Hint that it's something in the shader.

Installed Windows and chrome just to render the thing.
Fetched the render code with the help of the dev tools as hinted in the source code.
When opening the WebGPU devtool you are presented with only one shader module, and its code, I assumed something had to be hidden there.

Some images of how the tool looks can be found in its repo:  
https://github.com/takahirox/webgpu-devtools


It's a WGSL shader, based on looking at the code for a bit. Not that important, as I can't write or read it anyway :')

The arena is a ball bouncing around a 4x4 grid, I assume this is a sort of code that encodes the flag into the bounces.


So I start perusing the code and im met with a huge matrix of values, whole number floats, that looks like this:

```wgsl
local_2[0u] = 11.0;
local_2[1u] = 3.0;
local_2[2u] = 7.0;
local_2[3u] = 0.0;
local_2[4u] = 7.0;
local_2[5u] = 4.0;
local_2[6u] = 7.0;
local_2[7u] = 11.0;
[...]
local_2[369u] = 13.0;
local_2[370u] = 12.0;
local_2[371u] = 4.0;
```

I note that start pattern of the bounces matches the local_2 matrix. Note how 7.0 matches the orange cube i the video


Underneath this declaration the code starts:
All of this looks like code to calculate route based on framerate, then some math around "percentage of curve etc etc"

```wgsl
let _e888 = floor(((_e512 % 37200.0) * 0.01));
let _e889 = (_e512 % 100.0);
let _e890 = (_e889 * 0.01);
let _e895 = select(select(u32(_e888), 0u, (_e888 < 0.0)), 4294967295u, (_e888 > 4294967000.0));
if (_e895 < 372u) {
    let _e898 = local_2[_e895];
    let _e899 = (_e888 + 1.0);
    let _e905 = (select(select(u32(_e899), 0u, (_e899 < 0.0)), 4294967295u, (_e899 > 4294967000.0)) % 372u);
    if (_e905 < 372u) {
    } else {
        return;
    }
    let _e908 = local_2[_e905];
    let _e910 = floor((_e898 * 0.25));
    let _e912 = (_e898 % 4.0);
    let _e920 = fma(-(_e889), 0.01, 1.0);
    let _e923 = fma((_e910 - 1.5), _e920, ((floor((_e908 * 0.25)) - 1.5) * _e890));
    let _e924 = fma((_e912 - 1.5), _e920, (((_e908 % 4.0) - 1.5) * _e890));
    let _e925 = vec3<f32>(_e923, 0.0, _e924);
    let _e928 = fma(sin((_e889 * 0.03141593)), 2.0, 1.0);
    local_3 = (_e910 - 2.0);
    local_4 = (_e912 - 2.0);
    local_10 = vec3<f32>(_e925.x, _e928, _e925.z);
    local_11 = _e923;
    local_12 = _e928;
    local_13 = _e924;
    local_16 = _e923;
    local_17 = _e928;
    local_18 = _e924;
} else {
    return;
}
```

`_e895` selects the index, based on something, frame count I would guess.
`let _e910 = floor((_e898 * 0.25));` Select Row
`let _e912 = (_e898 % 4.0);` Selects the Col

No idea if this actually means anything, but it's something to keep in the back of my head.

Extracted all the values and converted them to a python script. Then tried to pair them up and see if they made any sense.

```python
pos = [...]

flag = ''.join([chr(pos[i] * 16 + pos[i + 1]) for i in range(0, len(pos), 2)])
print(flag)

```
```
³pt{Át{Ã®Ìu{y®Áu{Ï®vÊ{®q{{Î®y®qÊ{vtÃ¨®®ÌvyÁ®Áp®Á{xx®Áu{t¨®Áu{Ï®vÊ{®zËxqy|®ÁÊË{®ÌpÊxqÃ®y®Ê{vxÁÏ©®³pt{Át{Ã®®ÌvyÁ®Áp®Á{xx®Áu{t®pw®Áu{Ê®tÎpÊÁvys{®Áp®Áu{®ËyÇ{ÊÃ{©®¾±Âz>Å{qs>xpÊÍÄ
```

After trying some more iterations of pairing up and converting that all ended up in gibberish, I decided to try and see if I could find some more leads.

Next up for my part was to see if i could find the definitions of the colors anywhere, it was a chance that they were dynamically generated, but I was lucky and found it in the code.
Scrolling towards the buttom of the code I found this:
```wgsl
local_1[0u] = vec3<f32>(1.0, 0.88235295, 0.09803922);
local_1[1u] = vec3<f32>(0.98039216, 0.74509805, 0.83137256);
local_1[2u] = vec3<f32>(1.0, 0.98039216, 0.78431374);
local_1[3u] = vec3<f32>(0.8627451, 0.74509805, 1.0);
local_1[4u] = vec3<f32>(0.23529412, 0.7058824, 0.29411766);
local_1[5u] = vec3<f32>(0.0, 0.0, 0.5019608);
local_1[6u] = vec3<f32>(0.9607843, 0.50980395, 0.1882353);
local_1[7u] = vec3<f32>(0.6666667, 0.43137255, 0.15686275);
local_1[8u] = vec3<f32>(0.0, 0.50980395, 0.78431374);
local_1[9u] = vec3<f32>(0.5686275, 0.11764706, 0.7058824);
local_1[10u] = vec3<f32>(0.9019608, 0.09803922, 0.29411766);
local_1[11u] = vec3<f32>(0.27450982, 0.9411765, 0.9411765);
local_1[12u] = vec3<f32>(0.6666667, 1.0, 0.7647059);
local_1[13u] = vec3<f32>(0.5019608, 0.0, 0.0);
local_1[14u] = vec3<f32>(0.9411765, 0.19607843, 0.9019608);
local_1[15u] = vec3<f32>(0.8235294, 0.9607843, 0.23529412);
```

But right above this snippet there was something way more interesting:
```wgsl
local[0u] = 15u;
local[1u] = 4u;
local[2u] = 11u;
local[3u] = 3u;
local[4u] = 13u;
local[5u] = 8u;
local[6u] = 1u;
local[7u] = 6u;
local[8u] = 12u;
local[9u] = 14u;
local[10u] = 2u;
local[11u] = 5u;
local[12u] = 7u;
local[13u] = 10u;
local[14u] = 0u;
local[15u] = 9u;
```

This looks like a 1 to 1 char mapping! Lets try using the positions we found earlier and see if we can get something out of it.

```python
pos = [11, 3, 7, 0, 7, 4, 7, 11, 12, 1, 7, 15, 7, 4, 7, 11, 12, 3, 10, 14, 12, 12, 7, 5, 7, 11, 7, 9, 10, 14, 12, 1, 7,
       5, 7, 11, 12, 15, 10, 14, 7, 6, 12, 10, 7, 11, 10, 14, 7, 1, 7, 11, 7, 11, 12, 14, 10, 14, 7, 15, 7, 9, 10, 14,
       7, 1, 12, 10, 7, 11, 7, 6, 7, 4, 12, 3, 10, 8, 10, 14, 1, 15, 10, 14, 12, 12, 7, 6, 7, 9, 12, 1, 10, 14, 12, 1,
       7, 0, 10, 14, 12, 1, 7, 11, 7, 8, 7, 8, 10, 14, 12, 1, 7, 5, 7, 11, 7, 4, 10, 8, 10, 14, 12, 1, 7, 5, 7, 11, 12,
       15, 10, 14, 7, 6, 12, 10, 7, 11, 10, 14, 7, 10, 12, 11, 7, 15, 7, 8, 7, 1, 7, 15, 7, 9, 7, 12, 10, 14, 12, 1, 12,
       10, 12, 11, 7, 11, 10, 14, 12, 12, 7, 0, 12, 10, 7, 8, 7, 1, 12, 3, 10, 14, 7, 15, 7, 9, 10, 14, 12, 10, 7, 11,
       7, 6, 7, 8, 7, 15, 12, 1, 12, 15, 10, 9, 10, 14, 11, 3, 7, 0, 7, 4, 7, 11, 12, 1, 7, 15, 7, 4, 7, 11, 12, 3, 10,
       14, 1, 15, 10, 14, 12, 12, 7, 6, 7, 9, 12, 1, 10, 14, 12, 1, 7, 0, 10, 14, 12, 1, 7, 11, 7, 8, 7, 8, 10, 14, 12,
       1, 7, 5, 7, 11, 7, 4, 10, 14, 7, 0, 7, 7, 10, 14, 12, 1, 7, 5, 7, 11, 7, 15, 12, 10, 10, 14, 7, 15, 7, 4, 12, 14,
       7, 0, 12, 10, 12, 1, 7, 6, 7, 9, 7, 3, 7, 11, 10, 14, 12, 1, 7, 0, 10, 14, 12, 1, 7, 5, 7, 11, 10, 14, 12, 11, 7,
       9, 7, 15, 12, 7, 7, 11, 12, 10, 12, 3, 7, 11, 10, 9, 10, 14, 1, 11, 11, 14, 11, 1, 12, 2, 7, 10, 3, 14, 12, 5, 7,
       11, 7, 1, 7, 3, 3, 14, 7, 8, 7, 0, 12, 10, 12, 13, 12, 4]

remapping = [15, 4, 11, 3, 13, 8, 1, 6, 12, 14, 2, 5, 7, 10, 0, 9]


# For each p in pos, get the value at the index of p in remapping
# Take two and two bytes and make them into a ascii character, then join them all together
flag = ''.join([chr(remapping[pos[i]] * 16 + remapping[pos[i + 1]]) for i in range(0, len(pos), 2)])
print(flag)
```

**Output**:
```
Sometimes when they are deep in dreams, I want to tell them, they are building true worlds in reality. Sometimes I want to tell them of their importance to the universe. EPT{b0xedc0lorz}
```

**Flag:** `EPT{b0xedc0lorz}`
