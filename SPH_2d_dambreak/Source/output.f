      subroutine output(x, vx, mass, rho, p, u, c, itype, hsml, ntotal,
     &itimestep) 
      
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
      integer i, d, npart  

c file_id��ʾ����ļ��ı���ʱ�䲽 filename ����ļ��� 
      integer itimestep 
      character(len=100) file_id
      character(len=100) filename_f_xv, filename_f_state,
     &                    filename_f_other

c ��itimestep��ֵ���ַ������͵�file_id
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
        write(*,*)'����'
      end select

c �����ļ���Ϊ f_xv+��ǰʱ�䲽 f_state+��ǰʱ�䲽 f_other+��ǰʱ�䲽
c     file_name = 'file' // trim(adjustl(file_id)) // '.dat'  
  
      filename_f_xv = 'f_xv'//trim(file_id)//'.dat'
      filename_f_state = 'f_state'//trim(file_id)// '.dat'
      filename_f_other = 'f_other'//trim(file_id)// '.dat'

c      write(*,*) filename_f_xv

      open(11,file='data\'//trim(filename_f_xv))

      write(11,*)'TITLE="fluid particles"'
      write(11,*)'VARIABLES="i","X","Y","VX","VY","mass","density",
     &"pressure"'
      write(11,*)' ZONE I=100,J= 50, F=POINT'
      do i = 1, ntotal         
        write(11,1001) i,(x(d, i), d=1,dim),(vx(d, i),d = 1,dim),
     &                 mass(i),rho(i),p(i)                 
      enddo 
      
1001  format(1x, I6, 7(2x, e16.8))
                                      
      close(11)

      end           