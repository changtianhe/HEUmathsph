      subroutine p_gas(rho, u, p, c)
      
c----------------------------------------------------------------------
c   Gamma law EOS: subroutine to calculate the pressure and sound  
 
c     rho    : Density                                              [in]
c     u      : Internal energy                                      [in]
c     p      : Pressure                                            [out]
c     c      : sound velocity                                      [out]
          
      implicit none
      double precision rho, u, p, c   
      double precision gamma 
          
c      For air (idea gas)
c      See Equ.(3.82)

      gamma=1.4
      p = (gamma-1) * rho * u     
      c = sqrt((gamma-1) * u) 
     
      end         
      
      subroutine p_art_water(rho, p, c)
      
c----------------------------------------------------------------------
c   Artificial equation of state for the artificial compressibility 

c     rho    : Density                                              [in]
c     u      : Internal energy                                      [in]
c     p      : Pressure                                            [out]
c     c      : sound velocity                                      [out]
c     Equation of state for artificial compressibility   

      implicit none
      double precision rho, u, p,c
      double precision gamma, rho0,b,h,v_max,k

c     Artificial EOS, Form 1 (Monaghan, 1994) 
c     See Equ.(4.88)
      gamma=7.
      rho0=1000.
c     人工声速 最大速度的10倍左右以保证液体密度变化在1%以内
      v_max = sqrt(9.81*1.)
      c = 10. * v_max       
      b = c**2*rho0/gamma
c     b = 42000.
      p = b*((rho/rho0)**gamma-1)      

c     Artificial EOS, Form 2 (Morris, 1997)
c     See Equ.(4.89)
c     c = 0.01
c     for poiseuille problem
c     c = 10.*2.5e-5
c     for 2d dambreak 10*v_max = sqrt(2.*g*h)
c     人工声速，一般大于最大流体速度的10倍以上
c     h 高度m
c     h = 0.05
c     v_max = sqrt(2.*9.8*h)
c     系数k 取值 k ~0.0045
c      k = 0.25
c      c = k * 10*v_max
c      p = c**2 * rho   
      
      end 