      subroutine output(x, vx, mass, rho, p, u, c, itype, hsml, ntotal,
     &nvirt, itimestep) 
      
c----------------------------------------------------------------------           
c     Subroutine for saving particle information to external disk file

c     x-- coordinates of particles                                  [in]
c     vx-- velocities of particles                                  [in]
c     mass-- mass of particles                                      [in]
c     rho-- dnesities of particles                                  [in]
c     p-- pressure  of particles                                    [in]
c     u-- internal energy of particles                              [in]
c     c-- sound velocity of particles                               [in]
c     itype-- types of particles                                    [in]
c     hsml-- smoothing lengths of particles                         [in]
c     ntotal-- total particle number                                [in]

      implicit none     
      include 'param.inc'
      
      integer itype(maxn), ntotal
      double precision x(maxdim, maxn), vx(maxdim, maxn), mass(maxn), 
     &       rho(maxn),p(maxn), u(maxn), c(maxn), hsml(maxn)
      integer i, d, npart ,nvirt 

c file_id表示输出文件的保存时间步 filename 输出文件名 
      integer itimestep 
      character(len=100) file_id
      character(len=100) filename_f_xv, filename_vp_xv

c 将itimestep赋值给字符串类型的file_id
      select case(itimestep)
      case (0:9)
        write(file_id,'(i1)') itimestep
      case (10:99)
        write(file_id,'(i2)') itimestep
      case (100:999)
        write(file_id,'(i3)') itimestep
      case (1000:9999)
        write(file_id,'(i4)') itimestep
      case (10000:99999)
        write(file_id,'(i5)') itimestep
      case (100000:999999)
        write(file_id,'(i6)') itimestep
      case default 
        write(*,*)'错误'
      end select

c 更改文件名为 f_xv+当前时间步 f_state+当前时间步 f_other+当前时间步
c     file_name = 'file' // trim(adjustl(file_id)) // '.dat'  
  
      filename_f_xv = 'f_xv'//trim(file_id)//'.dat'
      filename_vp_xv = 'vp_xv'//trim(file_id)// '.dat'

c      write(*,*) filename_f_xv

      open(11,file='data\'//trim(filename_f_xv))
      open(12,file='data\'//trim(filename_vp_xv))

      write(11,*)'TITLE="fluid particles"'
      write(11,*)'VARIABLES="X","Y","VX","VY","density","pressure"'
      write(11,*)' ZONE I=50,J= 50, F=POINT'
      do i = 1, ntotal         
        write(11,1001) (x(d, i), d=1,dim),(vx(d, i),d = 1,dim),
     &                rho(i),p(i)                 
      enddo 
      close(11)
      
      write(12,*)'TITLE=" boundary particles"'
      write(12,*)'VARIABLES="X","Y","VX","VY","density","pressure"'
      write(12,*)' ZONE I=803, F=POINT'
      do i = ntotal + 1, ntotal + nvirt         
        write(12,1001) (x(d, i), d=1,dim),(vx(d, i),d = 1,dim),
     &                rho(i),p(i)                 
      enddo 
      close(12)
      
1001  format( 6(2x, e16.8))
                                      
      

      end           