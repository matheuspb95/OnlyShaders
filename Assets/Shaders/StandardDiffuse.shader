Shader "Custom/StandardDiffuse" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_AmbientColor("Emissive Color", Color) = (1,1,1,1)		
		_Vector("Vector", Range(0,10)) = 0.5
		_NormalTex ("Normal Map", 2D) = "bump" {}
		_ScrollSpeed("Scroll Speed", Range(0, 10)) = 1 
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		float4 _Color;
		float4 _AmbientColor;
		float _Vector;
		sampler2D _NormalTex;
		float _ScrollSpeed;

		struct Input {
			float2 uv_NormalTex;
		};
		
		void surf (Input IN, inout SurfaceOutputStandard o) {
			fixed2 scrolledUV = IN.uv_NormalTex;
			float scrollvalue = _ScrollSpeed * _Time;
			scrolledUV += fixed2(0, scrollvalue);
			
			// Albedo comes from a texture tinted by color
			float3 normalMap = UnpackNormal(tex2D(_NormalTex,
			scrolledUV));
			// Apply the new normal to the lighting model
			o.Normal = normalMap.rgb;

			fixed4 c = _Color;
			o.Emission = _AmbientColor;
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
