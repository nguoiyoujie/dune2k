%include "macros/patch.inc"
%include "macros/hack.inc"
%include "vars/global.inc"


@CLEAR 0x00460FD3, 0x90, 0x00460FD8
@HACK 0x00460FD3, AdjustGUIxUI_LANG_r
	cmp byte[_HighResPatchEnabled], 1
	jnz .out
	cmp dword[eax], 320
	jbe .out
	mov ecx, dword[_HighResAddedWidth]
	add dword[eax], ecx
.out:
	mov ecx, dword[eax]
	add eax,4
	jmp 0x00460FD8
@ENDHACK


@HACK 0x00460FDF, AdjustGUIyUI_LANG_r
	cmp byte[_HighResPatchEnabled], 1
	jnz .out
	cmp dword[eax], 200
	jbe .out
	mov edx, dword[_HighResAddedHeight]
	add dword[eax], edx
.out:
	mov edx, dword[eax]
	add eax,4
	jmp 0x00460FE4
@ENDHACK


@HACK 0x0044423A, patch1
	cmp byte[_HighResPatchEnabled], 1
	jz .patch
	push 0x004DFDD4
	jmp 0x0044423F
.patch:
	pop edi
	pop esi
	pop ebp
	pop ebx
	add esp,0x0CC
	retn
	jmp 0x0044424C
@ENDHACK
	

@HACK 0x004442F7, patch2
	cmp byte[_HighResPatchEnabled], 1
	jz .patch
	push 0x004DFDD4
	jmp 0x004442FC
.patch:
	pop edi
	pop esi
	pop ebp
	pop ebx
	add esp,0x0CC
	retn
	jmp 0x00444309
@ENDHACK


@HACK 0x00444D79, patch3
	cmp byte[_HighResPatchEnabled], 1
	jz .patch
	mov eax,dword[0x4E4208]
	jmp 0x00444D7E
.patch:
	mov eax,0x0B8
	cmp ecx,eax
	jle 0x00445010
	mov ebx,0x2F
	mov edx,ebx
	imul edx, dword[_SideBarIconCount]
	add edx,eax
	cmp ecx,edx
	jge 0x0044500B
	mov eax,dword[0x516430]
	cmp eax,0x3
	jnz 0x00444E16
	xchg eax,ecx
	mov ecx,0x0B8
	sub eax,ecx
	cdq
	div ebx
	add edi, dword[_ScreenUnk4]
	lea ecx, [edi]
	sub edi, dword[_ScreenUnk4]
	cmp eax,0x3
	jg 0x00445010
	jmp 0x00444DBF
@ENDHACK


@CLEAR 0x0044BB50, 0x90, 0x0044BB58
@HACK 0x0044BB50, patch4
	cmp byte[_HighResPatchEnabled], 1
	jz .patch
	mov eax,ecx
	mov ecx,dword[0x4E41FC]
	jmp 0x0044BB58
.patch:
	xchg eax,ecx
	mov ecx,dword[0x4E41FC]
	shr eax,0x1
	add ecx,edx
	xor edx,edx
	add eax,ecx
	mov CX,0x0B8
	mov dword[esp+0x14],eax
	mov eax,dword[0x4EB04C]
	sub eax,ecx
	add edx,0x2F
	div dl
	cbw
	mov ecx,edx
	shr edx,0x1
	imul ecx,eax
	mov dword[esp+0x10],eax
	mov eax,dword[0x4E4200]
	add eax,ecx
	add edx,eax
	mov eax,dword[0x516430]
	mov ecx,dword[esp+0x10]
	xor ebx,ebx
	inc ebx
	jmp 0x0044BB96
@ENDHACK


@HACK 0x0044BE0B, patch5
	cmp byte[_HighResPatchEnabled], 1
	jz .patch
	cmp eax,1
	jbe 0x0044BE15
	jmp 0x0044BE10
.patch:
	cmp eax,ebx
	jbe .loc1
	xchg eax,ebx
.loc1:
	cmp ecx,0x3
	jg 0x0044C10F
	jmp 0x0044BE19
@ENDHACK


@CLEAR 0x004A3E9D, 0x90, 0x004A3EA4
@HACK 0x004A3E9D, patch6 ;align top left
	cmp byte[_HighResPatchEnabled], 1
	jz .patch
	sar eax,1
	mov dword[0x7984D8],eax
	jmp 0x004A3EA4
.patch:
	xor eax,eax
	mov dword[0x7984D8],eax
	jmp 0x004A3EA4
@ENDHACK
