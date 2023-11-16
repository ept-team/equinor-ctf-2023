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
    var position: array<f32, 372>;
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
    position[0u] = 11.0;
    position[1u] = 3.0;
    position[2u] = 7.0;
    position[3u] = 0.0;
    position[4u] = 7.0;
    position[5u] = 4.0;
    position[6u] = 7.0;
    position[7u] = 11.0;
    position[8u] = 12.0;
    position[9u] = 1.0;
    position[10u] = 7.0;
    position[11u] = 15.0;
    position[12u] = 7.0;
    position[13u] = 4.0;
    position[14u] = 7.0;
    position[15u] = 11.0;
    position[16u] = 12.0;
    position[17u] = 3.0;
    position[18u] = 10.0;
    position[19u] = 14.0;
    position[20u] = 12.0;
    position[21u] = 12.0;
    position[22u] = 7.0;
    position[23u] = 5.0;
    position[24u] = 7.0;
    position[25u] = 11.0;
    position[26u] = 7.0;
    position[27u] = 9.0;
    position[28u] = 10.0;
    position[29u] = 14.0;
    position[30u] = 12.0;
    position[31u] = 1.0;
    position[32u] = 7.0;
    position[33u] = 5.0;
    position[34u] = 7.0;
    position[35u] = 11.0;
    position[36u] = 12.0;
    position[37u] = 15.0;
    position[38u] = 10.0;
    position[39u] = 14.0;
    position[40u] = 7.0;
    position[41u] = 6.0;
    position[42u] = 12.0;
    position[43u] = 10.0;
    position[44u] = 7.0;
    position[45u] = 11.0;
    position[46u] = 10.0;
    position[47u] = 14.0;
    position[48u] = 7.0;
    position[49u] = 1.0;
    position[50u] = 7.0;
    position[51u] = 11.0;
    position[52u] = 7.0;
    position[53u] = 11.0;
    position[54u] = 12.0;
    position[55u] = 14.0;
    position[56u] = 10.0;
    position[57u] = 14.0;
    position[58u] = 7.0;
    position[59u] = 15.0;
    position[60u] = 7.0;
    position[61u] = 9.0;
    position[62u] = 10.0;
    position[63u] = 14.0;
    position[64u] = 7.0;
    position[65u] = 1.0;
    position[66u] = 12.0;
    position[67u] = 10.0;
    position[68u] = 7.0;
    position[69u] = 11.0;
    position[70u] = 7.0;
    position[71u] = 6.0;
    position[72u] = 7.0;
    position[73u] = 4.0;
    position[74u] = 12.0;
    position[75u] = 3.0;
    position[76u] = 10.0;
    position[77u] = 8.0;
    position[78u] = 10.0;
    position[79u] = 14.0;
    position[80u] = 1.0;
    position[81u] = 15.0;
    position[82u] = 10.0;
    position[83u] = 14.0;
    position[84u] = 12.0;
    position[85u] = 12.0;
    position[86u] = 7.0;
    position[87u] = 6.0;
    position[88u] = 7.0;
    position[89u] = 9.0;
    position[90u] = 12.0;
    position[91u] = 1.0;
    position[92u] = 10.0;
    position[93u] = 14.0;
    position[94u] = 12.0;
    position[95u] = 1.0;
    position[96u] = 7.0;
    position[97u] = 0.0;
    position[98u] = 10.0;
    position[99u] = 14.0;
    position[100u] = 12.0;
    position[101u] = 1.0;
    position[102u] = 7.0;
    position[103u] = 11.0;
    position[104u] = 7.0;
    position[105u] = 8.0;
    position[106u] = 7.0;
    position[107u] = 8.0;
    position[108u] = 10.0;
    position[109u] = 14.0;
    position[110u] = 12.0;
    position[111u] = 1.0;
    position[112u] = 7.0;
    position[113u] = 5.0;
    position[114u] = 7.0;
    position[115u] = 11.0;
    position[116u] = 7.0;
    position[117u] = 4.0;
    position[118u] = 10.0;
    position[119u] = 8.0;
    position[120u] = 10.0;
    position[121u] = 14.0;
    position[122u] = 12.0;
    position[123u] = 1.0;
    position[124u] = 7.0;
    position[125u] = 5.0;
    position[126u] = 7.0;
    position[127u] = 11.0;
    position[128u] = 12.0;
    position[129u] = 15.0;
    position[130u] = 10.0;
    position[131u] = 14.0;
    position[132u] = 7.0;
    position[133u] = 6.0;
    position[134u] = 12.0;
    position[135u] = 10.0;
    position[136u] = 7.0;
    position[137u] = 11.0;
    position[138u] = 10.0;
    position[139u] = 14.0;
    position[140u] = 7.0;
    position[141u] = 10.0;
    position[142u] = 12.0;
    position[143u] = 11.0;
    position[144u] = 7.0;
    position[145u] = 15.0;
    position[146u] = 7.0;
    position[147u] = 8.0;
    position[148u] = 7.0;
    position[149u] = 1.0;
    position[150u] = 7.0;
    position[151u] = 15.0;
    position[152u] = 7.0;
    position[153u] = 9.0;
    position[154u] = 7.0;
    position[155u] = 12.0;
    position[156u] = 10.0;
    position[157u] = 14.0;
    position[158u] = 12.0;
    position[159u] = 1.0;
    position[160u] = 12.0;
    position[161u] = 10.0;
    position[162u] = 12.0;
    position[163u] = 11.0;
    position[164u] = 7.0;
    position[165u] = 11.0;
    position[166u] = 10.0;
    position[167u] = 14.0;
    position[168u] = 12.0;
    position[169u] = 12.0;
    position[170u] = 7.0;
    position[171u] = 0.0;
    position[172u] = 12.0;
    position[173u] = 10.0;
    position[174u] = 7.0;
    position[175u] = 8.0;
    position[176u] = 7.0;
    position[177u] = 1.0;
    position[178u] = 12.0;
    position[179u] = 3.0;
    position[180u] = 10.0;
    position[181u] = 14.0;
    position[182u] = 7.0;
    position[183u] = 15.0;
    position[184u] = 7.0;
    position[185u] = 9.0;
    position[186u] = 10.0;
    position[187u] = 14.0;
    position[188u] = 12.0;
    position[189u] = 10.0;
    position[190u] = 7.0;
    position[191u] = 11.0;
    position[192u] = 7.0;
    position[193u] = 6.0;
    position[194u] = 7.0;
    position[195u] = 8.0;
    position[196u] = 7.0;
    position[197u] = 15.0;
    position[198u] = 12.0;
    position[199u] = 1.0;
    position[200u] = 12.0;
    position[201u] = 15.0;
    position[202u] = 10.0;
    position[203u] = 9.0;
    position[204u] = 10.0;
    position[205u] = 14.0;
    position[206u] = 11.0;
    position[207u] = 3.0;
    position[208u] = 7.0;
    position[209u] = 0.0;
    position[210u] = 7.0;
    position[211u] = 4.0;
    position[212u] = 7.0;
    position[213u] = 11.0;
    position[214u] = 12.0;
    position[215u] = 1.0;
    position[216u] = 7.0;
    position[217u] = 15.0;
    position[218u] = 7.0;
    position[219u] = 4.0;
    position[220u] = 7.0;
    position[221u] = 11.0;
    position[222u] = 12.0;
    position[223u] = 3.0;
    position[224u] = 10.0;
    position[225u] = 14.0;
    position[226u] = 1.0;
    position[227u] = 15.0;
    position[228u] = 10.0;
    position[229u] = 14.0;
    position[230u] = 12.0;
    position[231u] = 12.0;
    position[232u] = 7.0;
    position[233u] = 6.0;
    position[234u] = 7.0;
    position[235u] = 9.0;
    position[236u] = 12.0;
    position[237u] = 1.0;
    position[238u] = 10.0;
    position[239u] = 14.0;
    position[240u] = 12.0;
    position[241u] = 1.0;
    position[242u] = 7.0;
    position[243u] = 0.0;
    position[244u] = 10.0;
    position[245u] = 14.0;
    position[246u] = 12.0;
    position[247u] = 1.0;
    position[248u] = 7.0;
    position[249u] = 11.0;
    position[250u] = 7.0;
    position[251u] = 8.0;
    position[252u] = 7.0;
    position[253u] = 8.0;
    position[254u] = 10.0;
    position[255u] = 14.0;
    position[256u] = 12.0;
    position[257u] = 1.0;
    position[258u] = 7.0;
    position[259u] = 5.0;
    position[260u] = 7.0;
    position[261u] = 11.0;
    position[262u] = 7.0;
    position[263u] = 4.0;
    position[264u] = 10.0;
    position[265u] = 14.0;
    position[266u] = 7.0;
    position[267u] = 0.0;
    position[268u] = 7.0;
    position[269u] = 7.0;
    position[270u] = 10.0;
    position[271u] = 14.0;
    position[272u] = 12.0;
    position[273u] = 1.0;
    position[274u] = 7.0;
    position[275u] = 5.0;
    position[276u] = 7.0;
    position[277u] = 11.0;
    position[278u] = 7.0;
    position[279u] = 15.0;
    position[280u] = 12.0;
    position[281u] = 10.0;
    position[282u] = 10.0;
    position[283u] = 14.0;
    position[284u] = 7.0;
    position[285u] = 15.0;
    position[286u] = 7.0;
    position[287u] = 4.0;
    position[288u] = 12.0;
    position[289u] = 14.0;
    position[290u] = 7.0;
    position[291u] = 0.0;
    position[292u] = 12.0;
    position[293u] = 10.0;
    position[294u] = 12.0;
    position[295u] = 1.0;
    position[296u] = 7.0;
    position[297u] = 6.0;
    position[298u] = 7.0;
    position[299u] = 9.0;
    position[300u] = 7.0;
    position[301u] = 3.0;
    position[302u] = 7.0;
    position[303u] = 11.0;
    position[304u] = 10.0;
    position[305u] = 14.0;
    position[306u] = 12.0;
    position[307u] = 1.0;
    position[308u] = 7.0;
    position[309u] = 0.0;
    position[310u] = 10.0;
    position[311u] = 14.0;
    position[312u] = 12.0;
    position[313u] = 1.0;
    position[314u] = 7.0;
    position[315u] = 5.0;
    position[316u] = 7.0;
    position[317u] = 11.0;
    position[318u] = 10.0;
    position[319u] = 14.0;
    position[320u] = 12.0;
    position[321u] = 11.0;
    position[322u] = 7.0;
    position[323u] = 9.0;
    position[324u] = 7.0;
    position[325u] = 15.0;
    position[326u] = 12.0;
    position[327u] = 7.0;
    position[328u] = 7.0;
    position[329u] = 11.0;
    position[330u] = 12.0;
    position[331u] = 10.0;
    position[332u] = 12.0;
    position[333u] = 3.0;
    position[334u] = 7.0;
    position[335u] = 11.0;
    position[336u] = 10.0;
    position[337u] = 9.0;
    position[338u] = 10.0;
    position[339u] = 14.0;
    position[340u] = 1.0;
    position[341u] = 11.0;
    position[342u] = 11.0;
    position[343u] = 14.0;
    position[344u] = 11.0;
    position[345u] = 1.0;
    position[346u] = 12.0;
    position[347u] = 2.0;
    position[348u] = 7.0;
    position[349u] = 10.0;
    position[350u] = 3.0;
    position[351u] = 14.0;
    position[352u] = 12.0;
    position[353u] = 5.0;
    position[354u] = 7.0;
    position[355u] = 11.0;
    position[356u] = 7.0;
    position[357u] = 1.0;
    position[358u] = 7.0;
    position[359u] = 3.0;
    position[360u] = 3.0;
    position[361u] = 14.0;
    position[362u] = 7.0;
    position[363u] = 8.0;
    position[364u] = 7.0;
    position[365u] = 0.0;
    position[366u] = 12.0;
    position[367u] = 10.0;
    position[368u] = 12.0;
    position[369u] = 13.0;
    position[370u] = 12.0;
    position[371u] = 4.0;
    let _e888 = floor(((_e512 % 37200.0) * 0.01));
    let percentage_100 = (_e512 % 100.0);
    let percentage_1 = (percentage_100 * 0.01);
    let index = select(select(u32(_e888), 0u, (_e888 < 0.0)), 4294967295u, (_e888 > 4294967000.0));
    if (index < 372u) {
        let value = position[index];
        let _e899 = (_e888 + 1.0);
        let _e905 = (select(select(u32(_e899), 0u, (_e899 < 0.0)), 4294967295u, (_e899 > 4294967000.0)) % 372u);
        if (_e905 < 372u) {
        } else {
            return;
        }
        let _e908 = position[_e905];
        let row_index = floor((value * 0.25));
        let col_index = (value % 4.0);
        let _e920 = fma(-(percentage_100), 0.01, 1.0); // Same as a * b + c
        let _e923 = fma((row_index - 1.5), _e920, ((floor((_e908 * 0.25)) - 1.5) * percentage_1));
        let _e924 = fma((col_index - 1.5), _e920, (((_e908 % 4.0) - 1.5) * percentage_1));
        let _e925 = vec3<f32>(_e923, 0.0, _e924);
        let _e928 = fma(sin((percentage_100 * 0.03141593)), 2.0, 1.0);
        local_3 = (row_index - 2.0);
        local_4 = (col_index - 2.0);
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
            let _e1063 = fma(percentage_100, 0.01, (_e1061 * -0.05));
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
                remapping[0u] = 15u;
                remapping[1u] = 4u;
                remapping[2u] = 11u;
                remapping[3u] = 3u;
                remapping[4u] = 13u;
                remapping[5u] = 8u;
                remapping[6u] = 1u;
                remapping[7u] = 6u;
                remapping[8u] = 12u;
                remapping[9u] = 14u;
                remapping[10u] = 2u;
                remapping[11u] = 5u;
                remapping[12u] = 7u;
                remapping[13u] = 10u;
                remapping[14u] = 0u;
                remapping[15u] = 9u;
                colors[0u] = vec3<f32>(1.0, 0.88235295, 0.09803922);
                colors[1u] = vec3<f32>(0.98039216, 0.74509805, 0.83137256);
                colors[2u] = vec3<f32>(1.0, 0.98039216, 0.78431374);
                colors[3u] = vec3<f32>(0.8627451, 0.74509805, 1.0);
                colors[4u] = vec3<f32>(0.23529412, 0.7058824, 0.29411766);
                colors[5u] = vec3<f32>(0.0, 0.0, 0.5019608);
                colors[6u] = vec3<f32>(0.9607843, 0.50980395, 0.1882353);
                colors[7u] = vec3<f32>(0.6666667, 0.43137255, 0.15686275);
                colors[8u] = vec3<f32>(0.0, 0.50980395, 0.78431374);
                colors[9u] = vec3<f32>(0.5686275, 0.11764706, 0.7058824);
                colors[10u] = vec3<f32>(0.9019608, 0.09803922, 0.29411766);
                colors[11u] = vec3<f32>(0.27450982, 0.9411765, 0.9411765);
                colors[12u] = vec3<f32>(0.6666667, 1.0, 0.7647059);
                colors[13u] = vec3<f32>(0.5019608, 0.0, 0.0);
                colors[14u] = vec3<f32>(0.9411765, 0.19607843, 0.9019608);
                colors[15u] = vec3<f32>(0.8235294, 0.9607843, 0.23529412);
                let _e1529 = select(select(u32(_e1482), 0u, (_e1482 < 0.0)), 4294967295u, (_e1482 > 4294967000.0));
                if (_e1529 < 16u) {
                    let _e1532 = remapping[_e1529];
                    if (_e1532 < 16u) {
                    } else {
                        return;
                    }
                    let _e1535 = colors[_e1532];
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
