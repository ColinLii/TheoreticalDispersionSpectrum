! for calculate theoretical dispersion spectrum
! by zhengbl(lzb5868@mail.ustc.edu.cn) 
! mainly based on the generalized transmission/reflection coefficient
        include   "green_com.inc"

        integer   fff1, fff2
        real*8    f_1, f_2, amp0 ,win ,freal, window, t, ifftcoef
        real*8    random1,random2,random3
        complex*16   st0, sw
        complex*16   integf(n/2,10), integt(n,10)
        integer   imax, ifmax
        complex*16, allocatable :: rrr(:,:),zzz(:,:),ttt(:,:)
        real*8, allocatable :: Vph(:)
        complex*16,allocatable :: omega(:)
        complex*16:: integ(10)
        complex*16 cs,cp
        integer ii

!c  (0). Basic constants:
!c  -----------------------------
        aj = cmplx(0d0, 1d0)
        pi = 4d0*atan(1d0)
        pi2= 2d0*pi

!c  (1). Reading & Checking input:
!c  -------------------------------   
        call green_input

!c  (2). Basic parameters: 
!c  ----------------------
        call green_basic
!   
        oi = pi/Twin/10
        allocate(omega(no))
        allocate(Vph(nv))
        allocate(zzz(no,nv))
        allocate(rrr(no,nv))
        allocate(ttt(no,nv))
        do i=1,no
            omega(i) = (mino+(i-1)*(maxo-mino)/(no-1.0))*pi2 !-aj*oi
!           print *, omega(i)
        enddo
        do i=1,nv
            Vph(i) = minv+(i-1)*(maxv-minv)/(nv-1.0)
!            print *, Vph(i)
        enddo
        do i=1,no
            do ii=1,nly
                cs = (1.0+log(omega(i)/pi2/maxo)/(pi*Qs(ii))
     &               +aj/(2.0*Qs(ii)))
                cp = (1.0+log(omega(i)/pi2/maxo)/(pi*Qp(ii))
     &               +aj/(2.0*Qp(ii)))
                vs(ii) = vs0(ii)*cs
                vp(ii) = vp0(ii)*cp
            enddo
            do j =1,nv
                kn = omega(i)/Vph(j)
                !print *, kn
                o = omega(i) - aj*oi
                !print *, kn,o
                call funval(kn,o,integ)
                zzz(i,j) = integ(10)
            enddo
        enddo

        open(11,file=trim(Outname)//'.ds')
        do i=1,no
            do j=1,nv
            write (11, '(2e20.10)') abs(zzz(i,j))
           enddo
        end do
     
        close (11)

        end   


