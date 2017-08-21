// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "WF/Character/DiffuseOutline" 
{
	Properties 
	{
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Outline("Out line", float)=0.01
		[HideInInspector] _Color ("Color (RGB)", Color) = (1,1,1)
		[HideInInspector] _AddColor ("AddColor (RGB)", Color) = (0,0,0)
	}
	
	SubShader 
	{
		Tags { "RenderType"="Opaque" "Queue"="Geometry" "IgnoreProjector"="True" }
		LOD 150
		
		//2nd pass
		pass
		{
			Cull Front
			//ZWrite Off
			
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			
			float _Outline;
			
			struct v2f 
			{
				float4 pos : SV_POSITION;
			};
			
			v2f vert (appdata_base v) 
			{
				v2f o;
				
				o.pos = UnityObjectToClipPos(float4(v.vertex.xyz + v.normal * _Outline, 1));

				return o;
			}
			float4 frag(v2f i):COLOR
			{
				return float4(0,0,0,1);
			}
			ENDCG
		}

				//1st pass
		usepass "WF/Character/Diffuse/FORWARD"
		


	}
	Fallback "Mobile/VertexLit"
}
