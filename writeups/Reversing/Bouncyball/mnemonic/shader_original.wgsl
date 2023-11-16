struct type_3 {
    member: f32,
    member_1: f32,
    member_2: f32,
}

struct type_4 {
    member: type_3,
}

struct type_14 {
    member: f32,
    member_1: i32,
}

struct type_15 {
    member: vec3<f32>,
    member_1: type_14,
    member_2: f32,
    member_3: vec3<f32>,
}

struct type_16 {
    member: type_14,
    member_1: f32,
}

struct type_17 {
    member: vec3<f32>,
    member_1: type_14,
    member_2: f32,
    member_3: f32,
}

struct type_18 {
    member: vec3<f32>,
    member_1: f32,
}

var<private> global: vec4<f32>;
@group(0) @binding(0) 
var<uniform> global_1: type_4;
var<private> global_2: vec4<f32>;
var<private> global_3: i32;
var<private> global_4: vec4<f32> = vec4<f32>(0.0, 0.0, 0.0, 1.0);

fn function() {
    var local: array<u32, 16>;
    var local_1: array<vec3<f32>, 16>;
    var local_2: array<f32, 372>;
    var phi_2869_: f32;
    var phi_2870_: f32;
    var phi_2882_: f32;
    var phi_2883_: f32;
    var phi_2885_: i32;
    var phi_2886_: f32;
    var phi_2887_: f32;
    var phi_2888_: vec3<f32>;
    var local_3: f32;
    var local_4: f32;
    var phi_3072_: u32;
    var phi_3073_: type_14;
    var phi_3096_: bool;
    var phi_3106_: u32;
    var phi_3107_: type_14;
    var phi_3109_: bool;
    var phi_3110_: bool;
    var phi_3111_: u32;
    var phi_3112_: type_14;
    var phi_3121_: bool;
    var phi_3126_: type_14;
    var phi_3136_: type_14;
    var phi_3137_: type_16;
    var local_5: type_16;
    var local_6: type_16;
    var phi_2929_: f32;
    var phi_2930_: f32;
    var phi_2931_: vec3<f32>;
    var local_7: type_16;
    var phi_2950_: type_15;
    var phi_2952_: i32;
    var phi_2953_: f32;
    var phi_2954_: f32;
    var phi_2955_: vec3<f32>;
    var phi_2957_: bool;
    var phi_2958_: type_15;
    var phi_2959_: bool;
    var phi_2960_: i32;
    var phi_2961_: f32;
    var phi_2962_: f32;
    var phi_2963_: vec3<f32>;
    var phi_2972_: type_15;
    var local_8: type_15;
    var local_9: type_15;
    var phi_3394_: u32;
    var phi_3395_: f32;
    var phi_3396_: vec3<f32>;
    var phi_3397_: type_14;
    var local_10: vec3<f32>;
    var phi_3423_: bool;
    var phi_3435_: u32;
    var phi_3438_: type_14;
    var phi_3440_: bool;
    var phi_3441_: f32;
    var phi_3442_: vec3<f32>;
    var phi_3443_: bool;
    var phi_3444_: u32;
    var phi_3445_: f32;
    var phi_3446_: vec3<f32>;
    var phi_3447_: type_14;
    var phi_3456_: bool;
    var local_11: f32;
    var local_12: f32;
    var local_13: f32;
    var phi_3482_: vec3<f32>;
    var phi_3483_: type_14;
    var phi_3497_: type_14;
    var phi_3498_: type_17;
    var local_14: type_17;
    var local_15: type_17;
    var phi_2679_: bool;
    var phi_2685_: bool;
    var phi_2691_: bool;
    var phi_2697_: vec3<f32>;
    var local_16: f32;
    var local_17: f32;
    var local_18: f32;
    var phi_2776_: type_18;
    var phi_2798_: type_18;
    var local_19: vec3<f32>;

    let _e501 = global;
    let _e504 = global_1.member.member;
    let _e507 = global_1.member.member_1;
    let _e512 = global_1.member.member_2;
    let _e513 = (_e512 * 0.005);
    local_2[0u] = 11.0;
    local_2[1u] = 3.0;
    local_2[2u] = 7.0;
    local_2[3u] = 0.0;
    local_2[4u] = 7.0;
    local_2[5u] = 4.0;
    local_2[6u] = 7.0;
    local_2[7u] = 11.0;
    local_2[8u] = 12.0;
    local_2[9u] = 1.0;
    local_2[10u] = 7.0;
    local_2[11u] = 15.0;
    local_2[12u] = 7.0;
    local_2[13u] = 4.0;
    local_2[14u] = 7.0;
    local_2[15u] = 11.0;
    local_2[16u] = 12.0;
    local_2[17u] = 3.0;
    local_2[18u] = 10.0;
    local_2[19u] = 14.0;
    local_2[20u] = 12.0;
    local_2[21u] = 12.0;
    local_2[22u] = 7.0;
    local_2[23u] = 5.0;
    local_2[24u] = 7.0;
    local_2[25u] = 11.0;
    local_2[26u] = 7.0;
    local_2[27u] = 9.0;
    local_2[28u] = 10.0;
    local_2[29u] = 14.0;
    local_2[30u] = 12.0;
    local_2[31u] = 1.0;
    local_2[32u] = 7.0;
    local_2[33u] = 5.0;
    local_2[34u] = 7.0;
    local_2[35u] = 11.0;
    local_2[36u] = 12.0;
    local_2[37u] = 15.0;
    local_2[38u] = 10.0;
    local_2[39u] = 14.0;
    local_2[40u] = 7.0;
    local_2[41u] = 6.0;
    local_2[42u] = 12.0;
    local_2[43u] = 10.0;
    local_2[44u] = 7.0;
    local_2[45u] = 11.0;
    local_2[46u] = 10.0;
    local_2[47u] = 14.0;
    local_2[48u] = 7.0;
    local_2[49u] = 1.0;
    local_2[50u] = 7.0;
    local_2[51u] = 11.0;
    local_2[52u] = 7.0;
    local_2[53u] = 11.0;
    local_2[54u] = 12.0;
    local_2[55u] = 14.0;
    local_2[56u] = 10.0;
    local_2[57u] = 14.0;
    local_2[58u] = 7.0;
    local_2[59u] = 15.0;
    local_2[60u] = 7.0;
    local_2[61u] = 9.0;
    local_2[62u] = 10.0;
    local_2[63u] = 14.0;
    local_2[64u] = 7.0;
    local_2[65u] = 1.0;
    local_2[66u] = 12.0;
    local_2[67u] = 10.0;
    local_2[68u] = 7.0;
    local_2[69u] = 11.0;
    local_2[70u] = 7.0;
    local_2[71u] = 6.0;
    local_2[72u] = 7.0;
    local_2[73u] = 4.0;
    local_2[74u] = 12.0;
    local_2[75u] = 3.0;
    local_2[76u] = 10.0;
    local_2[77u] = 8.0;
    local_2[78u] = 10.0;
    local_2[79u] = 14.0;
    local_2[80u] = 1.0;
    local_2[81u] = 15.0;
    local_2[82u] = 10.0;
    local_2[83u] = 14.0;
    local_2[84u] = 12.0;
    local_2[85u] = 12.0;
    local_2[86u] = 7.0;
    local_2[87u] = 6.0;
    local_2[88u] = 7.0;
    local_2[89u] = 9.0;
    local_2[90u] = 12.0;
    local_2[91u] = 1.0;
    local_2[92u] = 10.0;
    local_2[93u] = 14.0;
    local_2[94u] = 12.0;
    local_2[95u] = 1.0;
    local_2[96u] = 7.0;
    local_2[97u] = 0.0;
    local_2[98u] = 10.0;
    local_2[99u] = 14.0;
    local_2[100u] = 12.0;
    local_2[101u] = 1.0;
    local_2[102u] = 7.0;
    local_2[103u] = 11.0;
    local_2[104u] = 7.0;
    local_2[105u] = 8.0;
    local_2[106u] = 7.0;
    local_2[107u] = 8.0;
    local_2[108u] = 10.0;
    local_2[109u] = 14.0;
    local_2[110u] = 12.0;
    local_2[111u] = 1.0;
    local_2[112u] = 7.0;
    local_2[113u] = 5.0;
    local_2[114u] = 7.0;
    local_2[115u] = 11.0;
    local_2[116u] = 7.0;
    local_2[117u] = 4.0;
    local_2[118u] = 10.0;
    local_2[119u] = 8.0;
    local_2[120u] = 10.0;
    local_2[121u] = 14.0;
    local_2[122u] = 12.0;
    local_2[123u] = 1.0;
    local_2[124u] = 7.0;
    local_2[125u] = 5.0;
    local_2[126u] = 7.0;
    local_2[127u] = 11.0;
    local_2[128u] = 12.0;
    local_2[129u] = 15.0;
    local_2[130u] = 10.0;
    local_2[131u] = 14.0;
    local_2[132u] = 7.0;
    local_2[133u] = 6.0;
    local_2[134u] = 12.0;
    local_2[135u] = 10.0;
    local_2[136u] = 7.0;
    local_2[137u] = 11.0;
    local_2[138u] = 10.0;
    local_2[139u] = 14.0;
    local_2[140u] = 7.0;
    local_2[141u] = 10.0;
    local_2[142u] = 12.0;
    local_2[143u] = 11.0;
    local_2[144u] = 7.0;
    local_2[145u] = 15.0;
    local_2[146u] = 7.0;
    local_2[147u] = 8.0;
    local_2[148u] = 7.0;
    local_2[149u] = 1.0;
    local_2[150u] = 7.0;
    local_2[151u] = 15.0;
    local_2[152u] = 7.0;
    local_2[153u] = 9.0;
    local_2[154u] = 7.0;
    local_2[155u] = 12.0;
    local_2[156u] = 10.0;
    local_2[157u] = 14.0;
    local_2[158u] = 12.0;
    local_2[159u] = 1.0;
    local_2[160u] = 12.0;
    local_2[161u] = 10.0;
    local_2[162u] = 12.0;
    local_2[163u] = 11.0;
    local_2[164u] = 7.0;
    local_2[165u] = 11.0;
    local_2[166u] = 10.0;
    local_2[167u] = 14.0;
    local_2[168u] = 12.0;
    local_2[169u] = 12.0;
    local_2[170u] = 7.0;
    local_2[171u] = 0.0;
    local_2[172u] = 12.0;
    local_2[173u] = 10.0;
    local_2[174u] = 7.0;
    local_2[175u] = 8.0;
    local_2[176u] = 7.0;
    local_2[177u] = 1.0;
    local_2[178u] = 12.0;
    local_2[179u] = 3.0;
    local_2[180u] = 10.0;
    local_2[181u] = 14.0;
    local_2[182u] = 7.0;
    local_2[183u] = 15.0;
    local_2[184u] = 7.0;
    local_2[185u] = 9.0;
    local_2[186u] = 10.0;
    local_2[187u] = 14.0;
    local_2[188u] = 12.0;
    local_2[189u] = 10.0;
    local_2[190u] = 7.0;
    local_2[191u] = 11.0;
    local_2[192u] = 7.0;
    local_2[193u] = 6.0;
    local_2[194u] = 7.0;
    local_2[195u] = 8.0;
    local_2[196u] = 7.0;
    local_2[197u] = 15.0;
    local_2[198u] = 12.0;
    local_2[199u] = 1.0;
    local_2[200u] = 12.0;
    local_2[201u] = 15.0;
    local_2[202u] = 10.0;
    local_2[203u] = 9.0;
    local_2[204u] = 10.0;
    local_2[205u] = 14.0;
    local_2[206u] = 11.0;
    local_2[207u] = 3.0;
    local_2[208u] = 7.0;
    local_2[209u] = 0.0;
    local_2[210u] = 7.0;
    local_2[211u] = 4.0;
    local_2[212u] = 7.0;
    local_2[213u] = 11.0;
    local_2[214u] = 12.0;
    local_2[215u] = 1.0;
    local_2[216u] = 7.0;
    local_2[217u] = 15.0;
    local_2[218u] = 7.0;
    local_2[219u] = 4.0;
    local_2[220u] = 7.0;
    local_2[221u] = 11.0;
    local_2[222u] = 12.0;
    local_2[223u] = 3.0;
    local_2[224u] = 10.0;
    local_2[225u] = 14.0;
    local_2[226u] = 1.0;
    local_2[227u] = 15.0;
    local_2[228u] = 10.0;
    local_2[229u] = 14.0;
    local_2[230u] = 12.0;
    local_2[231u] = 12.0;
    local_2[232u] = 7.0;
    local_2[233u] = 6.0;
    local_2[234u] = 7.0;
    local_2[235u] = 9.0;
    local_2[236u] = 12.0;
    local_2[237u] = 1.0;
    local_2[238u] = 10.0;
    local_2[239u] = 14.0;
    local_2[240u] = 12.0;
    local_2[241u] = 1.0;
    local_2[242u] = 7.0;
    local_2[243u] = 0.0;
    local_2[244u] = 10.0;
    local_2[245u] = 14.0;
    local_2[246u] = 12.0;
    local_2[247u] = 1.0;
    local_2[248u] = 7.0;
    local_2[249u] = 11.0;
    local_2[250u] = 7.0;
    local_2[251u] = 8.0;
    local_2[252u] = 7.0;
    local_2[253u] = 8.0;
    local_2[254u] = 10.0;
    local_2[255u] = 14.0;
    local_2[256u] = 12.0;
    local_2[257u] = 1.0;
    local_2[258u] = 7.0;
    local_2[259u] = 5.0;
    local_2[260u] = 7.0;
    local_2[261u] = 11.0;
    local_2[262u] = 7.0;
    local_2[263u] = 4.0;
    local_2[264u] = 10.0;
    local_2[265u] = 14.0;
    local_2[266u] = 7.0;
    local_2[267u] = 0.0;
    local_2[268u] = 7.0;
    local_2[269u] = 7.0;
    local_2[270u] = 10.0;
    local_2[271u] = 14.0;
    local_2[272u] = 12.0;
    local_2[273u] = 1.0;
    local_2[274u] = 7.0;
    local_2[275u] = 5.0;
    local_2[276u] = 7.0;
    local_2[277u] = 11.0;
    local_2[278u] = 7.0;
    local_2[279u] = 15.0;
    local_2[280u] = 12.0;
    local_2[281u] = 10.0;
    local_2[282u] = 10.0;
    local_2[283u] = 14.0;
    local_2[284u] = 7.0;
    local_2[285u] = 15.0;
    local_2[286u] = 7.0;
    local_2[287u] = 4.0;
    local_2[288u] = 12.0;
    local_2[289u] = 14.0;
    local_2[290u] = 7.0;
    local_2[291u] = 0.0;
    local_2[292u] = 12.0;
    local_2[293u] = 10.0;
    local_2[294u] = 12.0;
    local_2[295u] = 1.0;
    local_2[296u] = 7.0;
    local_2[297u] = 6.0;
    local_2[298u] = 7.0;
    local_2[299u] = 9.0;
    local_2[300u] = 7.0;
    local_2[301u] = 3.0;
    local_2[302u] = 7.0;
    local_2[303u] = 11.0;
    local_2[304u] = 10.0;
    local_2[305u] = 14.0;
    local_2[306u] = 12.0;
    local_2[307u] = 1.0;
    local_2[308u] = 7.0;
    local_2[309u] = 0.0;
    local_2[310u] = 10.0;
    local_2[311u] = 14.0;
    local_2[312u] = 12.0;
    local_2[313u] = 1.0;
    local_2[314u] = 7.0;
    local_2[315u] = 5.0;
    local_2[316u] = 7.0;
    local_2[317u] = 11.0;
    local_2[318u] = 10.0;
    local_2[319u] = 14.0;
    local_2[320u] = 12.0;
    local_2[321u] = 11.0;
    local_2[322u] = 7.0;
    local_2[323u] = 9.0;
    local_2[324u] = 7.0;
    local_2[325u] = 15.0;
    local_2[326u] = 12.0;
    local_2[327u] = 7.0;
    local_2[328u] = 7.0;
    local_2[329u] = 11.0;
    local_2[330u] = 12.0;
    local_2[331u] = 10.0;
    local_2[332u] = 12.0;
    local_2[333u] = 3.0;
    local_2[334u] = 7.0;
    local_2[335u] = 11.0;
    local_2[336u] = 10.0;
    local_2[337u] = 9.0;
    local_2[338u] = 10.0;
    local_2[339u] = 14.0;
    local_2[340u] = 1.0;
    local_2[341u] = 11.0;
    local_2[342u] = 11.0;
    local_2[343u] = 14.0;
    local_2[344u] = 11.0;
    local_2[345u] = 1.0;
    local_2[346u] = 12.0;
    local_2[347u] = 2.0;
    local_2[348u] = 7.0;
    local_2[349u] = 10.0;
    local_2[350u] = 3.0;
    local_2[351u] = 14.0;
    local_2[352u] = 12.0;
    local_2[353u] = 5.0;
    local_2[354u] = 7.0;
    local_2[355u] = 11.0;
    local_2[356u] = 7.0;
    local_2[357u] = 1.0;
    local_2[358u] = 7.0;
    local_2[359u] = 3.0;
    local_2[360u] = 3.0;
    local_2[361u] = 14.0;
    local_2[362u] = 7.0;
    local_2[363u] = 8.0;
    local_2[364u] = 7.0;
    local_2[365u] = 0.0;
    local_2[366u] = 12.0;
    local_2[367u] = 10.0;
    local_2[368u] = 12.0;
    local_2[369u] = 13.0;
    local_2[370u] = 12.0;
    local_2[371u] = 4.0;
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
    let _e935 = sin(_e513);
    let _e936 = (5.0 * _e935);
    let _e937 = cos(_e513);
    let _e938 = (5.0 * _e937);
    let _e939 = vec3<f32>(_e936, 5.0, _e938);
    let _e940 = (_e935 * -5.0);
    let _e941 = (_e937 * -5.0);
    let _e944 = sqrt(fma(_e941, _e941, fma(_e940, _e940, 9.0)));
    let _e945 = (1.0 / _e944);
    let _e946 = (_e940 * _e945);
    let _e947 = (-3.0 / _e944);
    let _e948 = (_e941 * _e945);
    let _e949 = -(_e948);
    let _e953 = (1.0 / sqrt(fma(_e949, _e949, (_e946 * _e946))));
    let _e954 = (_e949 * _e953);
    let _e955 = (_e946 * _e953);
    let _e957 = -((_e947 * _e955));
    let _e960 = fma(_e955, _e946, -((_e948 * _e954)));
    let _e961 = (_e954 * _e947);
    let _e966 = (1.0 / sqrt(fma(_e961, _e961, fma(_e957, _e957, (_e960 * _e960)))));
    let _e977 = (fma(2.0, _e501.x, -(_e504)) / _e507);
    let _e978 = (fma(2.0, _e501.y, -(_e507)) / _e507);
    let _e982 = sqrt((fma(_e977, _e977, (_e978 * _e978)) + 4.0));
    let _e983 = (1.0 / _e982);
    let _e984 = (_e977 * _e983);
    let _e985 = (_e978 * _e983);
    let _e986 = (2.0 / _e982);
    let _e992 = fma(_e946, _e986, fma(_e954, _e984, (-((_e957 * _e966)) * _e985)));
    let _e993 = fma(-((_e960 * _e966)), _e985, (_e947 * _e986));
    let _e994 = fma(_e948, _e986, fma(_e955, _e984, (-((_e961 * _e966)) * _e985)));
    let _e1004 = fma(0.5, cos((_e512 * 0.0062831803)), 0.5);
    let _e1005 = fma(0.5, cos((6.28318 * fma(_e512, 0.001, 0.33))), 0.5);
    let _e1006 = fma(0.5, cos((6.28318 * fma(_e512, 0.001, 0.67))), 0.5);
    let _e1007 = floor(_e936);
    let _e1008 = floor(_e938);
    let _e1013 = bitcast<f32>((1065353216u | (bitcast<u32>(_e992) & 2147483648u)));
    let _e1017 = bitcast<f32>((1065353216u | (bitcast<u32>(_e994) & 2147483648u)));
    if (_e992 != 0.0) {
        let _e1023 = (1.0 / _e992);
        phi_2869_ = (_e1013 * _e1023);
        phi_2870_ = (fma(-5.0, _e935, fma((_e1013 + 1.0), 0.5, _e1007)) * _e1023);
    } else {
        phi_2869_ = 0.0;
        phi_2870_ = 1000000.0;
    }
    let _e1028 = phi_2869_;
    let _e1030 = phi_2870_;
    if (_e994 != 0.0) {
        let _e1032 = (1.0 / _e994);
        phi_2882_ = (_e1017 * _e1032);
        phi_2883_ = (fma(-5.0, _e937, fma((_e1017 + 1.0), 0.5, _e1008)) * _e1032);
    } else {
        phi_2882_ = 0.0;
        phi_2883_ = 1000000.0;
    }
    let _e1037 = phi_2882_;
    let _e1039 = phi_2883_;
    phi_2885_ = 0;
    phi_2886_ = _e1039;
    phi_2887_ = _e1030;
    phi_2888_ = vec3<f32>(_e1007, 0.0, _e1008);
    loop {
        let _e1041 = phi_2885_;
        let _e1043 = phi_2886_;
        let _e1045 = phi_2887_;
        let _e1047 = phi_2888_;
        if (_e1041 < 30) {
            let _e1051 = local_3;
            let _e1052 = (_e1047.x - _e1051);
            let _e1056 = local_4;
            let _e1057 = (_e1047.z - _e1056);
            let _e1061 = sqrt(fma(_e1057, _e1057, fma(_e1052, _e1052, (_e1047.y * _e1047.y))));
            let _e1063 = fma(_e889, 0.01, (_e1061 * -0.05));
            let _e1065 = select(_e1063, 0.0, (_e1063 < 0.0));
            let _e1067 = select(_e1065, 0.5, (_e1065 > 0.5));
            let _e1075 = ((sin((_e1067 * 12.566371)) * -1.0) * max(fma(-(_e1061), 0.05, 1.0), 0.0));
            let _e1078 = ((0.5 / max((_e1067 * 2.0), 0.5)) - 0.5);
            let _e1079 = (_e1047.x + 0.5);
            let _e1080 = (_e1047.z + 0.5);
            phi_3072_ = 0u;
            phi_3073_ = type_14(0.0, 0);
            loop {
                let _e1082 = phi_3072_;
                let _e1084 = phi_3073_;
                if (_e1082 < 128u) {
                    let _e1091 = (_e939 + vec3<f32>((_e992 * _e1084.member), (_e993 * _e1084.member), (_e994 * _e1084.member)));
                    let _e1102 = (abs((_e1091.x - _e1079)) - 0.39900002);
                    let _e1103 = (abs(fma(-(_e1075), _e1078, _e1091.y)) - 0.39900002);
                    let _e1104 = (abs((_e1091.z - _e1080)) - 0.39900002);
                    let _e1105 = max(_e1102, 0.0);
                    let _e1106 = max(_e1103, 0.0);
                    let _e1107 = max(_e1104, 0.0);
                    let _e1116 = ((sqrt(fma(_e1107, _e1107, fma(_e1105, _e1105, (_e1106 * _e1106)))) + min(max(_e1102, max(_e1103, _e1104)), 0.0)) - 0.1);
                    if (_e1116 < (_e1084.member * 0.0001)) {
                        phi_3096_ = true;
                    } else {
                        phi_3096_ = (_e1084.member > 100.0);
                    }
                    let _e1121 = phi_3096_;
                    if _e1121 {
                        phi_3106_ = u32();
                        phi_3107_ = type_14();
                    } else {
                        phi_3106_ = (_e1082 + 1u);
                        phi_3107_ = type_14((_e1084.member + _e1116), _e1084.member_1);
                    }
                    let _e1128 = phi_3106_;
                    let _e1130 = phi_3107_;
                    phi_3109_ = select(false, true, _e1121);
                    phi_3110_ = select(true, false, _e1121);
                    phi_3111_ = _e1128;
                    phi_3112_ = _e1130;
                } else {
                    phi_3109_ = true;
                    phi_3110_ = false;
                    phi_3111_ = u32();
                    phi_3112_ = type_14();
                }
                let _e1134 = phi_3109_;
                let _e1136 = phi_3110_;
                let _e1138 = phi_3111_;
                let _e1140 = phi_3112_;
                if _e1134 {
                    if (_e1084.member > 100.0) {
                        phi_3121_ = true;
                    } else {
                        phi_3121_ = (_e1082 == 128u);
                    }
                    let _e1145 = phi_3121_;
                    if _e1145 {
                        phi_3126_ = type_14(1000000.0, -1);
                    } else {
                        phi_3126_ = _e1084;
                    }
                    let _e1147 = phi_3126_;
                    phi_3136_ = type_14();
                    phi_3137_ = type_16(_e1147, f32(_e1082));
                } else {
                    phi_3136_ = _e1140;
                    phi_3137_ = type_16();
                }
                let _e1151 = phi_3136_;
                let _e1153 = phi_3137_;
                local_5 = _e1153;
                local_6 = _e1153;
                local_7 = _e1153;
                continue;
                continuing {
                    phi_3072_ = select(_e1138, u32(), _e1134);
                    phi_3073_ = _e1151;
                    break if !(select(_e1136, false, _e1134));
                }
            }
            let _e1158 = local_5;
            let _e1162 = local_6;
            let _e1164 = (_e1158.member.member < 1000000.0);
            if _e1164 {
                let _e1189 = (_e939 + vec3<f32>((_e992 * _e1158.member.member), (_e993 * _e1158.member.member), (_e994 * _e1158.member.member)));
                let _e1190 = (_e1189 + vec3<f32>(0.0001, -0.0001, -0.0001));
                let _e1194 = -(_e1075);
                let _e1201 = (abs((_e1190.x - _e1079)) - 0.39900002);
                let _e1202 = (abs(fma(_e1194, _e1078, _e1190.y)) - 0.39900002);
                let _e1203 = (abs((_e1190.z - _e1080)) - 0.39900002);
                let _e1204 = max(_e1201, 0.0);
                let _e1205 = max(_e1202, 0.0);
                let _e1206 = max(_e1203, 0.0);
                let _e1215 = ((sqrt(fma(_e1206, _e1206, fma(_e1204, _e1204, (_e1205 * _e1205)))) + min(max(_e1201, max(_e1202, _e1203)), 0.0)) - 0.1);
                let _e1216 = (_e1189 + vec3<f32>(-0.0001, -0.0001, 0.0001));
                let _e1226 = (abs((_e1216.x - _e1079)) - 0.39900002);
                let _e1227 = (abs(fma(_e1194, _e1078, _e1216.y)) - 0.39900002);
                let _e1228 = (abs((_e1216.z - _e1080)) - 0.39900002);
                let _e1229 = max(_e1226, 0.0);
                let _e1230 = max(_e1227, 0.0);
                let _e1231 = max(_e1228, 0.0);
                let _e1240 = ((sqrt(fma(_e1231, _e1231, fma(_e1229, _e1229, (_e1230 * _e1230)))) + min(max(_e1226, max(_e1227, _e1228)), 0.0)) - 0.1);
                let _e1245 = (_e1189 + vec3<f32>(-0.0001, 0.0001, -0.0001));
                let _e1255 = (abs((_e1245.x - _e1079)) - 0.39900002);
                let _e1256 = (abs(fma(_e1194, _e1078, _e1245.y)) - 0.39900002);
                let _e1257 = (abs((_e1245.z - _e1080)) - 0.39900002);
                let _e1258 = max(_e1255, 0.0);
                let _e1259 = max(_e1256, 0.0);
                let _e1260 = max(_e1257, 0.0);
                let _e1269 = ((sqrt(fma(_e1260, _e1260, fma(_e1258, _e1258, (_e1259 * _e1259)))) + min(max(_e1255, max(_e1256, _e1257)), 0.0)) - 0.1);
                let _e1273 = (_e1189 + vec3<f32>(0.0001, 0.0001, 0.0001));
                let _e1283 = (abs((_e1273.x - _e1079)) - 0.39900002);
                let _e1284 = (abs(fma(_e1194, _e1078, _e1273.y)) - 0.39900002);
                let _e1285 = (abs((_e1273.z - _e1080)) - 0.39900002);
                let _e1286 = max(_e1283, 0.0);
                let _e1287 = max(_e1284, 0.0);
                let _e1288 = max(_e1285, 0.0);
                let _e1297 = ((sqrt(fma(_e1288, _e1288, fma(_e1286, _e1286, (_e1287 * _e1287)))) + min(max(_e1283, max(_e1284, _e1285)), 0.0)) - 0.1);
                let _e1298 = (fma(-1.0, _e1269, fma(-1.0, _e1240, _e1215)) + _e1297);
                let _e1299 = ((fma(-1.0, _e1215, (-1.0 * _e1240)) + _e1269) + _e1297);
                let _e1300 = (fma(-1.0, _e1269, fma(-1.0, _e1215, _e1240)) + _e1297);
                let _e1305 = (1.0 / sqrt(fma(_e1300, _e1300, fma(_e1298, _e1298, (_e1299 * _e1299)))));
                let _e1311 = local_7;
                phi_2950_ = type_15(vec3<f32>((_e1298 * _e1305), (_e1299 * _e1305), (_e1300 * _e1305)), _e1311.member, _e1162.member_1, _e1047);
                phi_2952_ = i32();
                phi_2953_ = f32();
                phi_2954_ = f32();
                phi_2955_ = vec3<f32>();
            } else {
                if (_e1045 < _e1043) {
                    phi_2929_ = _e1043;
                    phi_2930_ = (_e1045 + _e1028);
                    phi_2931_ = vec3<f32>((_e1047.x + _e1013), _e1047.y, _e1047.z);
                } else {
                    phi_2929_ = (_e1043 + _e1037);
                    phi_2930_ = _e1045;
                    phi_2931_ = vec3<f32>(_e1047.x, _e1047.y, (_e1047.z + _e1017));
                }
                let _e1179 = phi_2929_;
                let _e1181 = phi_2930_;
                let _e1183 = phi_2931_;
                phi_2950_ = type_15();
                phi_2952_ = (_e1041 + 1);
                phi_2953_ = _e1179;
                phi_2954_ = _e1181;
                phi_2955_ = _e1183;
            }
            let _e1315 = phi_2950_;
            let _e1317 = phi_2952_;
            let _e1319 = phi_2953_;
            let _e1321 = phi_2954_;
            let _e1323 = phi_2955_;
            phi_2957_ = select(false, true, _e1164);
            phi_2958_ = _e1315;
            phi_2959_ = select(true, false, _e1164);
            phi_2960_ = _e1317;
            phi_2961_ = _e1319;
            phi_2962_ = _e1321;
            phi_2963_ = _e1323;
        } else {
            phi_2957_ = true;
            phi_2958_ = type_15(vec3<f32>(1.0, 1.0, 0.0), type_14(1000000.0, -1), -1.0, vec3<f32>(0.0, 1.0, 1.0));
            phi_2959_ = false;
            phi_2960_ = i32();
            phi_2961_ = f32();
            phi_2962_ = f32();
            phi_2963_ = vec3<f32>();
        }
        let _e1327 = phi_2957_;
        let _e1329 = phi_2958_;
        let _e1331 = phi_2959_;
        let _e1333 = phi_2960_;
        let _e1335 = phi_2961_;
        let _e1337 = phi_2962_;
        let _e1339 = phi_2963_;
        if _e1327 {
            phi_2972_ = _e1329;
        } else {
            phi_2972_ = type_15();
        }
        let _e1341 = phi_2972_;
        local_8 = _e1341;
        local_9 = _e1341;
        continue;
        continuing {
            phi_2885_ = select(_e1333, i32(), _e1327);
            phi_2886_ = select(_e1335, f32(), _e1327);
            phi_2887_ = select(_e1337, f32(), _e1327);
            phi_2888_ = select(_e1339, vec3<f32>(), vec3<bool>(_e1327));
            break if !(select(_e1331, false, _e1327));
        }
    }
    let _e1350 = local_8;
    let _e1354 = local_9;
    phi_3394_ = 0u;
    phi_3395_ = 1000.0;
    phi_3396_ = vec3<f32>(0.0, 0.0, 0.0);
    phi_3397_ = type_14(0.0, -1);
    loop {
        let _e1357 = phi_3394_;
        let _e1359 = phi_3395_;
        let _e1361 = phi_3396_;
        let _e1363 = phi_3397_;
        if (_e1357 < 128u) {
            let _e1370 = (_e939 + vec3<f32>((_e992 * _e1363.member), (_e993 * _e1363.member), (_e994 * _e1363.member)));
            let _e1372 = local_10;
            let _e1373 = (_e1370 - _e1372);
            let _e1381 = (sqrt(fma(_e1373.z, _e1373.z, fma(_e1373.x, _e1373.x, (_e1373.y * _e1373.y)))) - 0.4);
            let _e1382 = min(_e1381, _e1359);
            if (_e1381 < (_e1363.member * 0.001)) {
                phi_3423_ = true;
            } else {
                phi_3423_ = (_e1363.member > 50.0);
            }
            let _e1387 = phi_3423_;
            if _e1387 {
                phi_3435_ = u32();
                phi_3438_ = type_14();
            } else {
                phi_3435_ = (_e1357 + 1u);
                phi_3438_ = type_14((_e1363.member + _e1381), 1);
            }
            let _e1392 = phi_3435_;
            let _e1394 = phi_3438_;
            let _e1397 = vec3<bool>(_e1387);
            phi_3440_ = select(false, true, _e1387);
            phi_3441_ = select(f32(), _e1382, _e1387);
            phi_3442_ = select(vec3<f32>(), _e1370, _e1397);
            phi_3443_ = select(true, false, _e1387);
            phi_3444_ = _e1392;
            phi_3445_ = select(_e1382, f32(), _e1387);
            phi_3446_ = select(_e1370, vec3<f32>(), _e1397);
            phi_3447_ = _e1394;
        } else {
            phi_3440_ = true;
            phi_3441_ = _e1359;
            phi_3442_ = _e1361;
            phi_3443_ = false;
            phi_3444_ = u32();
            phi_3445_ = f32();
            phi_3446_ = vec3<f32>();
            phi_3447_ = type_14();
        }
        let _e1403 = phi_3440_;
        let _e1405 = phi_3441_;
        let _e1407 = phi_3442_;
        let _e1409 = phi_3443_;
        let _e1411 = phi_3444_;
        let _e1413 = phi_3445_;
        let _e1415 = phi_3446_;
        let _e1417 = phi_3447_;
        if _e1403 {
            if (_e1363.member > 50.0) {
                phi_3456_ = true;
            } else {
                phi_3456_ = (_e1357 == 128u);
            }
            let _e1422 = phi_3456_;
            if _e1422 {
                phi_3482_ = vec3<f32>(0.0, 0.0, 0.0);
                phi_3483_ = type_14(1000000.0, -1);
            } else {
                let _e1425 = local_11;
                let _e1426 = (_e1407.x - _e1425);
                let _e1429 = local_12;
                let _e1430 = (_e1407.y - _e1429);
                let _e1433 = local_13;
                let _e1434 = (_e1407.z - _e1433);
                let _e1439 = (1.0 / sqrt(fma(_e1434, _e1434, fma(_e1426, _e1426, (_e1430 * _e1430)))));
                phi_3482_ = vec3<f32>((_e1426 * _e1439), (_e1430 * _e1439), (_e1434 * _e1439));
                phi_3483_ = _e1363;
            }
            let _e1445 = phi_3482_;
            let _e1447 = phi_3483_;
            phi_3497_ = type_14();
            phi_3498_ = type_17(_e1445, _e1447, f32(_e1357), _e1405);
        } else {
            phi_3497_ = _e1417;
            phi_3498_ = type_17();
        }
        let _e1451 = phi_3497_;
        let _e1453 = phi_3498_;
        local_14 = _e1453;
        local_15 = _e1453;
        continue;
        continuing {
            phi_3394_ = select(_e1411, u32(), _e1403);
            phi_3395_ = select(_e1413, f32(), _e1403);
            phi_3396_ = select(_e1415, vec3<f32>(), vec3<bool>(_e1403));
            phi_3397_ = _e1451;
            break if !(select(_e1409, false, _e1403));
        }
    }
    let _e1461 = local_14;
    let _e1465 = local_15;
    if (_e1461.member_1.member < _e1350.member_1.member) {
        let _e1609 = fma(5.0, _e935, (_e992 * _e1461.member_1.member));
        let _e1610 = fma(_e993, _e1461.member_1.member, 5.0);
        let _e1611 = fma(5.0, _e937, (_e994 * _e1461.member_1.member));
        phi_2798_ = type_18(vec3<f32>(1.0, 1.0, 1.0), sqrt(fma(_e1611, _e1611, fma(_e1609, _e1609, (_e1610 * _e1610)))));
    } else {
        if (_e1461.member_1.member > _e1350.member_1.member) {
            let _e1469 = (_e992 * _e1350.member_1.member);
            let _e1470 = (_e994 * _e1350.member_1.member);
            let _e1471 = fma(5.0, _e935, _e1469);
            let _e1472 = fma(_e993, _e1350.member_1.member, 5.0);
            let _e1473 = fma(5.0, _e937, _e1470);
            let _e1475 = (_e939 + vec3<f32>(_e1469, f32(), _e1470));
            let _e1478 = (floor(_e1475.x) + 2.0);
            let _e1481 = (floor(_e1475.z) + 2.0);
            let _e1482 = fma(_e1478, 4.0, _e1481);
            if (_e1478 >= 0.0) {
                phi_2679_ = (_e1478 < 4.0);
            } else {
                phi_2679_ = false;
            }
            let _e1486 = phi_2679_;
            if _e1486 {
                phi_2685_ = (_e1481 >= 0.0);
            } else {
                phi_2685_ = false;
            }
            let _e1489 = phi_2685_;
            if _e1489 {
                phi_2691_ = (_e1481 < 4.0);
            } else {
                phi_2691_ = false;
            }
            let _e1492 = phi_2691_;
            if _e1492 {
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
                let _e1529 = select(select(u32(_e1482), 0u, (_e1482 < 0.0)), 4294967295u, (_e1482 > 4294967000.0));
                if (_e1529 < 16u) {
                    let _e1532 = local[_e1529];
                    if (_e1532 < 16u) {
                    } else {
                        return;
                    }
                    let _e1535 = local_1[_e1532];
                    local_19 = _e1535;
                } else {
                    return;
                }
                let _e1720 = local_19;
                phi_2697_ = _e1720;
            } else {
                phi_2697_ = vec3<f32>(0.1, 0.1, 0.1);
            }
            let _e1537 = phi_2697_;
            let _e1539 = local_16;
            let _e1540 = (_e1539 - _e1471);
            let _e1542 = local_17;
            let _e1543 = (_e1542 - _e1472);
            let _e1545 = local_18;
            let _e1546 = (_e1545 - _e1473);
            let _e1551 = (1.0 / sqrt(fma(_e1546, _e1546, fma(_e1540, _e1540, (_e1543 * _e1543)))));
            let _e1552 = (_e1540 * _e1551);
            let _e1553 = (_e1543 * _e1551);
            let _e1554 = (_e1546 * _e1551);
            let _e1562 = ((fma(_e1354.member.z, _e1554, fma(_e1354.member.x, _e1552, (_e1354.member.y * _e1553))) - -1.0) * 0.5);
            let _e1564 = select(_e1562, 0.0, (_e1562 < 0.0));
            let _e1566 = select(_e1564, 1.0, (_e1564 > 1.0));
            let _e1567 = (_e1566 * _e1566);
            let _e1568 = fma(-2.0, _e1566, 3.0);
            let _e1571 = fma(_e994, _e1354.member.z, fma(_e992, _e1354.member.x, (_e993 * _e1354.member.y)));
            let _e1579 = (vec3<f32>(_e992, _e993, _e994) - vec3<f32>(((_e1354.member.x * _e1571) * 2.0), ((_e1354.member.y * _e1571) * 2.0), ((_e1354.member.z * _e1571) * 2.0)));
            let _e1585 = fma(_e1579.z, _e1554, fma(_e1579.x, _e1552, (_e1579.y * _e1553)));
            let _e1587 = select(_e1585, 0.0, (_e1585 < 0.0));
            let _e1591 = (pow(select(_e1587, 1.0, (_e1587 > 1.0)), 10.0) * 2.0);
            phi_2776_ = type_18((_e1537 * vec3<f32>(fma(_e1567, _e1568, (_e1004 * _e1591)), fma(_e1567, _e1568, (_e1005 * _e1591)), fma(_e1567, _e1568, (_e1006 * _e1591)))), sqrt(fma(_e1473, _e1473, fma(_e1471, _e1471, (_e1472 * _e1472)))));
        } else {
            phi_2776_ = type_18(vec3<f32>(0.0, 0.0, 0.0), 1000000.0);
        }
        let _e1606 = phi_2776_;
        phi_2798_ = _e1606;
    }
    let _e1618 = phi_2798_;
    let _e1624 = exp((((-0.001 * _e1618.member_1) * _e1618.member_1) * _e1618.member_1));
    let _e1635 = pow((1.0 / max(0.0, (_e1465.member_3 * 10.0))), 1.0);
    let _e1640 = (vec3<f32>((_e1618.member.x * _e1624), (_e1618.member.y * _e1624), (_e1618.member.z * _e1624)) + vec3<f32>((_e1004 * _e1635), (_e1005 * _e1635), (_e1006 * _e1635)));
    global_2 = vec4<f32>(_e1640.x, _e1640.y, _e1640.z, 1.0);
    return;
}

fn function_1() {
    let _e498 = global_3;
    global_4 = vec4<f32>(fma(2.0, f32(((_e498 << bitcast<u32>(1)) & 2)), -1.0), fma(2.0, f32((_e498 & 2)), -1.0), 0.0, 1.0);
    return;
}

@fragment 
fn main_fs(@builtin(position) param: vec4<f32>) -> @location(0) vec4<f32> {
    global = param;
    function();
    let _e3 = global_2;
    return _e3;
}

@vertex 
fn main_vs(@builtin(vertex_index) param_1: u32) -> @builtin(position) vec4<f32> {
    global_3 = i32(param_1);
    function_1();
    let _e4 = global_4;
    return _e4;
}
