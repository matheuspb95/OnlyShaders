﻿Shader "Custom/CellShader" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_CellShadingLevels("Cell Levels", Range(0, 20)) = 0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Toon
		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
		float _CellShadingLevels;

		fixed4 LightingToon(SurfaceOutput s, fixed3 lightDir, fixed atten){
			half NdotL = dot(s.Normal, lightDir);
			half cel = floor(NdotL * _CellShadingLevels) / (_CellShadingLevels-0.5);

			fixed4 c;
			c.rgb = s.Albedo * _LightColor0.rgb * cel * atten;
			c.a = s.Alpha;

			return c;
		}

		struct Input {
			float2 uv_MainTex;
		};

		fixed4 _Color;

		void surf (Input IN, inout SurfaceOutput o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
