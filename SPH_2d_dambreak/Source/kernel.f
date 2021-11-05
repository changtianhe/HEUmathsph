      subroutine kernel(r,dx,hsml,w,dwdx)   

c----------------------------------------------------------------------
c   Subroutine to calculate the smoothing kernel wij and its 
c   derivatives dwdxij.
c     if skf = 1, cubic spline kernel by W4 - Spline (Monaghan 1985)
c            = 2, Gauss kernel   (Gingold and Monaghan 1981) 
c            = 3, Quintic kernel (Morris 1997)
c		     = 4, Wendland Quintic (Wendland, 1995)
c            = 5, new kernel 1 (hebangqi，一阶导单调递增改善压缩失稳)
c            = 6，new kernel 2 （杨秀峰，2012，一阶导单调递增改善压缩失稳）

c     r    : Distance between particles i and j                     [in]
c     dx   : x-, y- and z-distance between i and j                  [in]  
c     hsml : Smoothing length                                       [in]
c     w    : Kernel for all interaction pairs                      [out]
c     dwdx : Derivative of kernel with respect to x, y and z       [out]

      implicit none
      include 'param.inc'
      
      double precision r, dx(maxdim), hsml, w, dwdx(maxdim)
      integer i, j, d      
      double precision q, dw, factor

      q = r/hsml 
      w = 0.e0
      do d=1,dim         
        dwdx(d) = 0.e0
      enddo   

      if (skf.eq.1) then     
      
        if (dim.eq.1) then
          factor = 1.e0/hsml
        elseif (dim.eq.2) then
          factor = 15.e0/(7.e0*pi*hsml*hsml)
        elseif (dim.eq.3) then
          factor = 3.e0/(2.e0*pi*hsml*hsml*hsml)
        else
         print *,' >>> Error <<< : Wrong dimension: Dim =',dim
         stop
        endif                                           
        if (q.ge.0.and.q.le.1.e0) then          
          w = factor * (2./3. - q*q + q**3 / 2.)
          do d = 1, dim
            dwdx(d) = factor * (-2.+3./2.*q)/hsml**2 * dx(d)       
          enddo   
        else if (q.gt.1.e0.and.q.le.2) then          
          w = factor * 1.e0/6.e0 * (2.-q)**3 
          do d = 1, dim
            dwdx(d) =-factor * 1.e0/6.e0 * 3.*(2.-q)**2/hsml * (dx(d)/r)        
          enddo              
	else
	  w=0.
          do d= 1, dim
            dwdx(d) = 0.
          enddo             
        endif     
                                    
      else if (skf.eq.2) then
      
        factor = 1.e0 / (hsml**dim * pi**(dim/2.))      
	if(q.ge.0.and.q.le.3) then
	  w = factor * exp(-q*q)
          do d = 1, dim
            dwdx(d) = w * ( -2.* dx(d)/hsml/hsml)
          enddo 
	else
	  w = 0.
          do d = 1, dim
            dwdx(d) = 0.
          enddo 	   
	endif	       
	
      else if (skf.eq.3) then	
      
        if (dim.eq.1) then
          factor = 1.e0 / (120.e0*hsml)
        elseif (dim.eq.2) then
          factor = 7.e0 / (478.e0*pi*hsml*hsml)
        elseif (dim.eq.3) then
          factor = 1.e0 / (120.e0*pi*hsml*hsml*hsml)
        else
         print *,' >>> Error <<< : Wrong dimension: Dim =',dim
         stop
        endif              
	if(q.ge.0.and.q.le.1) then
          w = factor * ( (3-q)**5 - 6*(2-q)**5 + 15*(1-q)**5 )
          do d= 1, dim
            dwdx(d) = factor * ( (-120 + 120*q - 50*q**2) 
     &                        / hsml**2 * dx(d) )
          enddo 
	else if(q.gt.1.and.q.le.2) then
          w = factor * ( (3-q)**5 - 6*(2-q)**5 )
          do d= 1, dim
            dwdx(d) = factor * (-5*(3-q)**4 + 30*(2-q)**4)  
     &                       / hsml * (dx(d)/r) 
          enddo 
        else if(q.gt.2.and.q.le.3) then
          w = factor * (3-q)**5 
          do d= 1, dim
            dwdx(d) = factor * (-5*(3-q)**4) / hsml * (dx(d)/r) 
          enddo 
        else   
	  w = 0.
          do d = 1, dim
            dwdx(d) = 0.
          enddo  
        endif
        
        else if (skf.eq.4) then
      
            if (dim.eq.1) then
                factor = 1.e0 / (8.e0*hsml)
            elseif (dim.eq.2) then
                factor = 7.e0 / (4.e0*pi*hsml*hsml)
            elseif (dim.eq.3) then
                factor = 21.e0 / (16.e0*pi*hsml*hsml*hsml)
            else
                print *,' >>> Error <<< : Wrong dimension: Dim =',dim
                stop
            endif            
	if(q.ge.0.and.q.le.2) then
	  w = factor * (2.*q - 1)*(1 - q/2.)**4 
          do d = 1, dim
            dwdx(d)=factor*(2.*(1-q/2.)**4-(4.*q +2.)*(1-q/2.)**3)
     &                /hsml*(dx(d)/r) 
          enddo 
	else
	  w = 0.
          do d = 1, dim
            dwdx(d) = 0.
          enddo 	   
	endif	               
        
          else if (skf.eq.5) then	
      
        if (dim.eq.1) then
          factor = 1.e0 / (70.e0*hsml*hsml)
        elseif (dim.eq.2) then
          factor = 2.e0 / (875.e0*hsml*hsml)
        elseif (dim.eq.3) then
          factor = 1.e0 / (875.e0*hsml*hsml)
        else
         print *,' >>> Error <<< : Wrong dimension: Dim =',dim
         stop
        endif              
	if(q.ge.0.and.q.le.2) then
          w = factor * ( (16*q+33)*(2-q)**2 )
          do d= 1, dim
            dwdx(d) = factor*(16*(2-q)**2+(2*q-4)*(16*q+33))
     &                /hsml*(dx(d)/r)
          enddo 
        else   
	  w = 0.
          do d = 1, dim
            dwdx(d) = 0.
          enddo  
        endif 
        
        else if (skf.eq.6) then	
      
        if (dim.eq.1) then
          factor = 1.e0 / (7.e0*hsml)
        elseif (dim.eq.2) then
          factor = 1.e0 / (3.e0*pi*hsml*hsml)
        elseif (dim.eq.3) then
          factor = 15.e0 / (62.e0*pi*hsml*hsml*hsml)
        else
         print *,' >>> Error <<< : Wrong dimension: Dim =',dim
         stop
        endif              
	  if(q.ge.0.and.q.lt.1) then
          w = factor * (q **3 -6*q + 6)
          do d= 1, dim
            dwdx(d) = factor * ( 3*q**2 -6)/hsml*(dx(d)/r)
          enddo 
	  else if(q.gt.1.and.q.lt.2) then
          w = factor * (2-q)**3
          do d= 1, dim
            dwdx(d) = factor * (-3*(q-2)**2)/ hsml*(dx(d)/r) 
          enddo 
        else   
	    w = 0.
          do d = 1, dim
            dwdx(d) = 0.
          enddo  
        endif
          
      endif 
		
      end
