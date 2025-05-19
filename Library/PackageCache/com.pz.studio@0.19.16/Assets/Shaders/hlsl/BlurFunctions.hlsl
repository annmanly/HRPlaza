#ifndef BLUR_FUNCTIONS_INCLUDED
#define BLUR_FUNCTIONS_INCLUDED

Texture2D _BlitTexture;
SamplerState sampler_BlitTexture;

float4 BlurSample(float2 uv)
{
	return _BlitTexture.Sample(sampler_BlitTexture, uv);
}

void BlurSample_float(float2 uv, float offset, out float4 o)
{
	float i = offset;
	float2 res = float2(1.0f/1024.0f,1.0f/1024.0f);

	float4 col;
	col.rgba  = BlurSample(uv).rgba;
	col.rgba += BlurSample(uv + float2( i,  i) * res).rgba;
	col.rgba += BlurSample(uv + float2( i, -i) * res).rgba;
	col.rgba += BlurSample(uv + float2(-i,  i) * res).rgba;
	col.rgba += BlurSample(uv + float2(-i, -i) * res).rgba;
	col.rgba /= 5.0f;

	o = col;
}

#endif // BLUR_FUNCTIONS_INCLUDED
