// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/FragShader" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
	}
	SubShader {
		Pass {

			CGPROGRAM
			// Physically based Standard lighting model, and enable shadows on all light types
			#pragma vertex vert
			#pragma fragment frag

			// Use shader model 3.0 target, to get nicer looking lighting
			#pragma target 3.0

			sampler2D _MainTex;
			half4 _Color;

			struct vertInput {
				float4 pos : POSITION;
				float2 texcoord : TEXCOORD0;
			};

			struct vertOutput {
				float4 pos : SV_POSITION;
				float2 texcoord : TEXCOORD0;
			};

			vertOutput vert(vertInput input){
				vertOutput o;
				o.pos = UnityObjectToClipPos(input.pos);
				o.texcoord = input.texcoord;
				return o;
			}

			half4 frag(vertOutput output) : COLOR{
				half4 mainColor = tex2D(_MainTex, output.texcoord);
				return mainColor * _Color;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
