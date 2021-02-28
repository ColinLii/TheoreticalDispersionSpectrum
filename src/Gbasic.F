!c
        subroutine green_basic

!cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
!c   Note: The purpose of this subroutine is to assign values to  c
!c         some basic parameters, and calclulate values for some  c
!c         other basic parameters.                                c
!cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc

        include    "green_com.inc"	
	  real*8     amax, amin, vave

!c  SETTING BASIC PARAMETERS:
!c  -------------------------
!cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
        m1   = 2**(m-1)         ! Half of sampling points
        mt   = 2*m1             ! Total sampling points
	  dt   = Twin/(mt-1)
	  fmax = 1d0/(2d0*dt)	      ! Nyquist frequency
	  df   = fmax/(m1-1)	  ! frequency interval
 	  oi   = pi/Twin   ! imaginary frequency
	  
	  vmax = amax(nly,vp0)	  ! max velocity
	  vmin = amin(nly,vs0)	  ! min velocity
        vave = 0.5*(vmax+vmin)

        L = (vmax*Twin+r0+vmax/vave*dsqrt(r0*r0+(zs-z0)**2))+100        
	  dk   = pi2/L         ! k-integral step

	  print*,'!!!!!!!!!!!!!!!!!!! Basic Parameters !!!!!!!!!!!!!!!!!!'
	  write(*,100)  '              Time window width : Twin =',Twin
	  write(*,200)  '     Sample points(time domain) : mt   =',mt
	  write(*,100)  '       Source-receiver distance : R    =',r0
	  write(*,100)  '         Increment of time(sec) : dt   =',dt
	  write(*,100)  '           Cutoff frequency(Hz) : fmax =',fmax
	  write(*,100)  '     Increment of frequency(Hz) : df   =',df
	  write(*,100)  'The period structure length(km) : L    =',L
	  write(*,100)  ' Increment of wavenumber(km^-1) : dk   =',dk
	  print*,'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'

100     format(1x,a,f12.4)
200     format(1x,a,i5)

!c	  z(nly)=z(nly-1)+5.0

        do i = 1, nly 
           mu(i) = rho(i)*vs0(i)**2
        end do

!c       Identity matrix:
        unit(1,1) = 1d0
        unit(1,2) = 0d0
        unit(2,1) = 0d0
        unit(2,2) = 1d0

        RETURN
        END


