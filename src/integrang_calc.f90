      subroutine funval(k,o,integ)

      include "green_com.inc"

      real*8      :: k
      complex*16 :: e(4,4),a0(2),a1(2),a2(2),b1,b2,integ(10),fun(14)
      common      /ab012/a0,a1,a2,b1,b2

      do lay = 1, nly
         cpn(lay) = cdsqrt(k*k-(o/vp(lay))**2)
         csn(lay) = cdsqrt(k*k-(o/vs(lay))**2)
         if (real(cpn(lay)).lt.0d0) cpn(lay)=-cpn(lay)
         if (real(csn(lay)).lt.0d0) csn(lay)=-csn(lay)
      end do
      call grt_coefs(k, o)      
      call SourceVector_D(k,o) 
      call mtxe(lo, k, o, e)
      call Ydumtx(e)                
      call Uko_D

!      fun(1)=-b1*k
!      fun(2)=-a2(1)*k
!      fun(3)=a0(1)*k
!      fun(4)=b2*k
!      fun(5)=(b1-a1(1))*k
!      fun(6)=(a2(1)-b2)*k
!      fun(7)=a1(1)*k
!      fun(8)=a2(1)*k
!      fun(9)=fun(5)
!      fun(10)=-fun(6)
!      fun(11)=a2(2)*k
!      fun(12)=-a0(2)*k
!      fun(13)=a1(2)*k
!      fun(14)=-a2(2)*k

      fun(1)=-b1
      fun(2)=-a2(1)
      fun(3)=a0(1)
      fun(4)=b2
      fun(5)=(b1-a1(1))
      fun(6)=(a2(1)-b2)
      fun(7)=a1(1)
      fun(8)=a2(1)
      fun(9)=fun(5)
      fun(10)=-fun(6)
      fun(11)=a2(2)
      fun(12)=-a0(2)
      fun(13)=a1(2)
      fun(14)=-a2(2)

      integ(1)=fun(7)+fun(9)
      integ(2)=fun(8)+fun(10)
      integ(3)=fun(4)+fun(6)
      integ(4)=fun(1)+fun(5)
      integ(5)=fun(2)
      integ(6)=fun(3)
      integ(7)=fun(14)
      integ(8)=fun(13)
      integ(9)=fun(11)
      integ(10)=fun(12)

      return
      end subroutine funval
