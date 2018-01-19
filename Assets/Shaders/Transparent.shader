﻿Shader "Custom/Transparent" {
	Properties {
		
	}
	SubShader {
		GrabPass {

		}
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			sampler _GrabTexture;

			struct vertInput {
				float4 vertex : POSITION;
			};

			struct vertOutput {
				float4 vertex : POSITION;
				float4 uvgrab : TEXCOORD1;
			};

			vertOutput vert(vertInput v){
				vertOutput o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uvgrab = ComputeGrabScreenPos(o.vertex);
				return o;
			}

			half4 frag(vertOutput o) : COLOR {
				fixed4 col = tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(o.uvgrab));
				return col + half4(0.5, 0, 0, 0);
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
