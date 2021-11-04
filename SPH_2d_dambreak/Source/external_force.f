      subroutine ext_force(ntotal,mass,x,niac,pair_i,pair_j,
     &           itype,hsml,dvxdt)

c--------------------------------------------------------------------------
c     Subroutine to calculate the external forces, e.g. gravitational forces.      
c     The forces from the interactions with boundary virtual particles 
c     are also calculated here as external forces.

c     here as the external force. 
c     ntotal  : Number of particles                                 [in]
c     mass    : Particle masses                                     [in]
c     x       : Coordinates of all particles                        [in]
c     pair_i : List of first partner of interaction pair            [in]
c     pair_j : List of second partner of interaction pair           [in]
c     itype   : type of particles                                   [in]
c     hsml   : Smoothing Length                                     [in]
c     dvxdt   : Acceleration with respect to x, y and z            [out] 

      implicit none
      include 'param.inc'
      
      integer ntotal, itype(maxn), niac,
     &        pair_i(max_interaction), pair_j(max_interaction)
      double precision mass(maxn), x(maxdim,maxn), hsml(maxn),          
     &       dvxdt(maxdim,maxn)
      integer i, j, k, d
      double precision dx(maxdim), rr, f, rr0, dd, p1, p2,v_max    
           
      do i = 1, ntotal
        do d = 1, dim
          dvxdt(d, i) = 0.
	enddo
      enddo
        
c     Consider self-gravity or not ?

      if (self_gravity) then
        do i = 1, ntotal
          dvxdt(dim, i) = -9.8
        enddo
      endif 

c     Consider external force e.g. poiseuille flow

c      if (ex_force) then
c        do i = 1, ntotal
c          dvxdt(1, i) = 0.
c        enddo
c      endif 

c     Boundary particle force and penalty anti-penetration force. 
c     rr0 截止半径，表示边界粒子对流体粒子产生排斥力的作用范围，一般取水粒子初始间距大小
      rr0 = 0.01
      v_max = sqrt(9.8*1.)
      dd = v_max**2
      p1 = 12
      p2 = 4
      
      do  k=1,niac
        i = pair_i(k)
        j = pair_j(k)  
        if(itype(i).gt.0.and.itype(j).lt.0) then  
          rr = 0.      
          do d=1,dim
            dx(d) =  x(d,i) -  x(d,j)
            rr = rr + dx(d)*dx(d)
          enddo  
          rr = sqrt(rr)
          if(rr.lt.rr0) then
            f = ((rr0/rr)**p1-(rr0/rr)**p2)/rr**2
            do d = 1, dim
              dvxdt(d, i) = dvxdt(d, i) + dd*dx(d)*f
            enddo
          endif
        endif        
      enddo   
       
      end         