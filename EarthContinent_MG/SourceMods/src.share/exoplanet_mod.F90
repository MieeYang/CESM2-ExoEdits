

module exoplanet_mod

!------------------------------------------------------------------------------
! Purpose:  Stores basic exoplanet parameters -- set before compiling
!           These options override any other NCAR switches/options, etc when
!           this package is placed in SourceMods
!------------------------------------------------------------------------------
! NOTES ::

  use shr_kind_mod,    only: r8 => shr_kind_r8
  
  implicit none
  private
  save

  logical, public, parameter :: do_exo_atmconst = .true.        !! Read gas constituents of atmosphere from this file 

  !! Generic
  real(r8), public, parameter :: exo_planet_radius   = 6.37122e6_R8 !! radius ~ m
  real(r8), public, parameter :: exo_surface_gravity = 9.80616_R8          !! gravity ~ m/s^2            
  real(r8), public, parameter :: exo_ndays  = 1.0_R8*36.5                   !! scaler to number of Earth days.
  real(r8), public, parameter :: exo_porb = 365.0_r8                        !! orbital period, for ob    liquity cycle, and optionally for exo_sday
  real(r8), public, parameter :: exo_sday = 86400.0_r8 * exo_ndays / (1._r8 + exo_ndays/exo_porb)  !! sidereal period [sec]
    
  !! ============== ATMOSPHERIC CONSTITUENT PARAMETERS ============== !!
  !! Activated only if (do_exo_atmconst = .true.) 
  !! Must create matching initial conditions file (ncdata) !!
  real(r8), public, parameter :: exo_n2bar = 0.9996_r8                ! N2 inventory (bar)
  real(r8), public, parameter :: exo_h2bar = 0.0_r8                ! H2 inventory (bar)
  real(r8), public, parameter :: exo_co2bar = 0.0004_r8               ! CO2 inventory (bar)
  real(r8), public, parameter :: exo_ch4bar = 0.0_r8               ! CH4 inventory (bar)
  real(r8), public, parameter :: exo_pstd = (exo_n2bar + exo_h2bar + exo_co2bar+ exo_ch4bar)*1.0e5  ! total pressure (Pas360

  !! ============== FUNDAMENTAL CONSTANTS NEEDED USED BELOW ============== !!
  !! note there is some duplication with physconst.F90, keep private
  !! No need to modifications need below this point
  real(r8), parameter :: mwn2 = 28._r8
  real(r8), parameter :: mwh2 = 2._r8
  real(r8), parameter :: mwco2 = 44._r8
  real(r8), parameter :: mwch4 = 16._r8
  real(r8), parameter :: cpn2 = 1.039e3_r8
  real(r8), parameter :: cph2 = 14.32e3_r8
  real(r8), parameter :: cpco2 = 0.846e3_r8
  real(r8), parameter :: cpch4 = 2.226e3

  !! DERIVED CONSTANTS -- DO NOT MODIFY
  !! automatically calculated from above inputs in bar
  ! dry volume mixing ratios  kg/kmole
  real(r8), public, parameter :: exo_n2vmr = exo_n2bar / (exo_pstd/1.0e5)  
  real(r8), public, parameter :: exo_h2vmr = exo_h2bar / (exo_pstd/1.0e5)
  real(r8), public, parameter :: exo_co2vmr = exo_co2bar / (exo_pstd/1.0e5)
  real(r8), public, parameter :: exo_ch4vmr = exo_ch4bar / (exo_pstd/1.0e5)

  real(r8), public, parameter :: &   ! molecular weight of dry air
            exo_mwdair = exo_n2vmr*mwn2 + exo_h2vmr*mwh2 + exo_co2vmr*mwco2 + exo_ch4vmr*mwch4

  !! dry mass mixing ratios
  real(r8), public, parameter :: exo_n2mmr = exo_n2vmr * mwn2/exo_mwdair
  real(r8), public, parameter :: exo_h2mmr = exo_h2vmr * mwh2/exo_mwdair
  real(r8), public, parameter :: exo_co2mmr = exo_co2vmr * mwco2/exo_mwdair
  real(r8), public, parameter :: exo_ch4mmr = exo_ch4vmr * mwch4/exo_mwdair

  real(r8), public, parameter :: &   ! specific heat of dry, air J/kg/K
            exo_cpdair = exo_n2mmr*cpn2 + exo_h2mmr*cph2 + exo_co2mmr*cpco2 + exo_ch4mmr*cpch4


end module
