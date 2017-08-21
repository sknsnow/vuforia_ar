// Simplified Diffuse shader. Differences from regular Diffuse one:
// - no Main Color
// - fully supports only 1 directional light. Other lights can affect it, but it will be per-vertex/SH.

Shader "WF/Character/Diffuse" 
{
	Properties 
	{
		_MainTex ("Base (RGB)", 2D) = "white" {}
		[HideInInspector] _Color ("Color (RGB)", Color) = (1,1,1)
		[HideInInspector] _AddColor ("AddColor (RGB)", Color) = (0,0,0)
	}
	SubShader 
	{
		Tags { "RenderType"="Opaque" "Queue"="Geometry" "IgnoreProjector"="True" }
		LOD 150

		CGPROGRAM
		#pragma surface surf Lambert noforwardadd

		sampler2D _MainTex;
		fixed3 _Color;
		fixed3 _AddColor;

		struct Input 
		{
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) 
		{
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb * _Color + _AddColor;
			o.Alpha = 1;
		}
		ENDCG
	}
	Fallback "Mobile/VertexLit"
}
