Shader "Custom/Flicker" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Amount("Extrusion Amount", Range(-1, 1)) = 0
		_TimeMult("Time Multiplier", Range(0, 1)) = 0.5
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Lambert vertex:vert

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;		

		float rand(float3 co)
 		{
     		return frac(sin( dot(co.xyz ,float3(12.9898,78.233,45.5432) )) * 43758.5453);
 		}

		struct Input {
			float2 uv_MainTex;
		};

		fixed4 _Color;
		float _Amount;	
		float _TimeMult;	

		void vert(inout appdata_full v){
			v.vertex.xyz += v.normal * _Amount * rand(v.vertex.xyz * _Time * _TimeMult);
		}


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
