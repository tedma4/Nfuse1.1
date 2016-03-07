class PagesController < ApplicationController
  include Poly::Commentable

  # before_action :c, except:[:home, :help, :about, :feedback, :terms, 
  #                                  :privacy, :business_connector, :celebrity_connector, 
  #                                  :tv_show_connector, :fashion_connector, :youtubers,
  #                                  :sports_connector, :music_connector, :food_connector,
  #                                  :travel_connector, :test_page, :mytop50, :mostpopular,
  #                                  :random, :trending, :individual_post, :show#, :wiredtestthing
  #                                 ]
  before_action :page_from_params, only: :show
  # before_action :find_page, except:[:home, :help, :about, :feedback, :terms, 
  #                                  :privacy, :business_connector, :celebrity_connector, 
  #                                  :tv_show_connector, :fashion_connector, :youtubers,
  #                                  :sports_connector, :music_connector, :food_connector,
  #                                  :travel_connector, :test_page, :mytop50, :mostpopular,
  #                                  :random, :trending, :wiredtestthing
  #                                 ]
  #Blank is gonna be a reservered word for now
  def show
    # byebug
    page     = Biz::Timeline.new(@page)
    @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
    respond_to do |format|
      format.js {render show.js.erb}
      format.html
    end
    # render 'comp'
  end

  def show_forum
    byebug
    @page = Page.find_by_page_name(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def page_from_params
    @page = Page.find_by_page_name(params[:id])
  end
  
  def home
    if signed_in?
      @providers = Providers.for(current_user)
      # @token = []
      # if current_user.followed_users.any?
      #   current_user.followed_users.each do |i|
      #     @token << i.tokens.pluck(:provider, :uid, :access_token, :access_token_secret, :refresh_token)
      #   end
      #   unless @token.empty?
      #     @token = @token[0]
      #   else
      #     @token
      #   end
      # else
      #   @token
      # end
      timeline = []
      ids =  current_user.relationships.where(follow_type: 'User').collect(&:id)
      unless ids.empty?
        @users = User.where(id: ids)
        @users.find_each do |user|
          feed=Networks::Timeline.new(user)
          timeline << feed.construct(params)
          @unauthed_accounts = feed.unauthed_accounts
        end
      end
      @timeline=timeline.flatten.sort { |a, b| b.created_time <=> a.created_time}
    end
    # render 'home' is implicit.
  end

  def individual_post
    @post = {
    post_id: params[:post_id],
    provider: params[:provider],
    user: params[:user]
  }
    post_type = params[:post_type]
    if post_type == 'User'
      @user = User.find(@post[:user])
      @post_entry = Notification::Timeline.new(@post[:post_id],
                                               @post[:provider],
                                               @user).construct
    else
      @page = Page.find(@post[:user])
      @post_entry = Notification::Timeline.new(@post[:post_id],
                                               @post[:provider],
                                               @page).construct
    end
  end

  private
  # def find_page
  #   @page = Page.find_by(page_name: params[:action])
  # end

  # def set_page
  #   @page = Page.where(page_name: params[:action]).first_or_create!
  #   impressionist(@page)
  # end

  public

  def help; end
  def about; end
  def feedback; end
  def qanda; end
  def terms; end
  def privacy; end
  def business_connector; end
  def celebrity_connector; end
  def tv_show_connector; end
  def fashion_connector; end
  def youtubers; end
  def sports_connector; end
  def music_connector; end
  def food_connector; end
  def travel_connector; end
  def mytop50; end
  def mostpopular; end
  def random; end
  def trending; end

  end
# #####FASHION



# armanifashion                Armani            armani            https://www.youtube.com/user/Armani
# burberryfashion              Burberry          burberry          https://www.youtube.com/user/Burberry
# calvinkleinfashion           CalvinKlein       calvinklein       https://www.youtube.com/user/calvinklein
# chanel                CHANEL            chanelofficial    https://www.youtube.com/user/CHANEL
# christiandior         Dior              dior              https://www.youtube.com/user/Dior

# christianlouboutin    LouboutinWorld    louboutinworld    https://www.youtube.com/user/christianlouboutin
# dolceandgabbana       dolcegabbana      dolcegabbana      https://www.youtube.com/user/dolcegabbanachannel
# dkny                  dkny              dkny              https://www.youtube.com/user/dkny
# escada                ESCADA            escadaofficial    https://www.youtube.com/user/Escadaeditor
# fendi                 Fendi             fendi             https://www.youtube.com/user/FENDICHANNEL

# gucci                 gucci             gucci             https://www.youtube.com/user/gucciofficial
# prada                 Prada             prada             https://www.youtube.com/user/PRADA
# hugobossfashion              HUGOBOSS          hugoboss          https://www.youtube.com/user/HUGOBOSSTV
# johnvarvatos          johnvarvatos      johnvarvatos      https://www.youtube.com/user/johnvarvatos
# laperlalingerie       LaPerlaLingerie   laperlalingerie   https://www.youtube.com/user/LaPerlaLingerie

# louisvuitton          LouisVuitton      louisvuitton      https://www.youtube.com/user/LOUISVUITTON
# manoloblahnik         ManoloBlahnik     manoloblahnikhq   https://www.youtube.com/channel/UCBldabiGA8UYQQgbwyI-jyw
# missoni               Missoni           missoni           https://www.youtube.com/user/MissoniOfficial
# ralphlaurenfashion           RalphLauren       ralphlauren       https://www.youtube.com/user/RLTVralphlauren
# rolandmouret          RolandMouret      roland_mouret     https://www.youtube.com/user/RolandMouretFilms

# stellamccartney       StellaMcCartney   stellamccartney   https://www.youtube.com/user/stellamccartney1
# tomford               TOMFORD           tomford           https://www.youtube.com/user/TOMFORDINTERNATIONAL
# versace               Versace           versace_official  https://www.youtube.com/user/VersaceVideos
# michaelkors           MichaelKors       michaelkors       https://www.youtube.com/user/michaelkors

###########YOUTUBER


# tyleroakley         tyleroakley       tyleroakley         https://www.youtube.com/user/tyleroakley
# troyesivan          troyesivan        troyesivan          https://www.youtube.com/user/TroyeSivan18
# zoella              ZoellaBeauty      zozeebo             https://www.youtube.com/user/zoella280390
# connorfranta        ConnorFranta      connorfranta        https://www.youtube.com/user/ConnorFranta
# ijustine            ijustine          ijustine            https://www.youtube.com/user/ijustine

# glozell             GloZell           glozell             https://www.youtube.com/user/glozell1
# jennamarbles        Jenna_Marbles     jennamarbles        https://www.youtube.com/user/JennaMarbles
# alfiedeyes          PointlessBlog     pointlessblog       https://www.youtube.com/user/PointlessBlog
# shanedawson         shanedawson       shanedawson         https://www.youtube.com/user/shane
# joeygraceffa        JoeyGraceffa      joeygraceffa        https://www.youtube.com/user/JoeyGraceffa

# rebeccablack        MsRebeccaBlack    justcallmerebecca   https://www.youtube.com/user/rebecca
# pewdiepie           pewdiepie         pewdiepie           https://www.youtube.com/user/PewDiePie
# smosh               smosh             smosh               https://www.youtube.com/user/smosh
# nigahiga            Niga_Higa         nigahiga_           https://www.youtube.com/user/nigahiga
# tobuscus            Tobuscus          tobuscus            https://www.youtube.com/user/Tobuscus

# sawyerhartman       SawyerHartman     sawyerhartman       https://www.youtube.com/user/sawyerhartman
# annoyingorange      annoyingorange    annoyingorange      https://www.youtube.com/user/realannoyingorange
# rhettandlink        rhettandlink      rhettandlink        https://www.youtube.com/user/RhettandLink
# itskingsleybitch    kingsleyyy        kingsleyyy          https://www.youtube.com/user/ItsKingsleyBitch
# jimchapman          JimsTweetings     jimalfredchapman    https://www.youtube.com/user/j1mmyb0bba

# danisnotonfire      danisnotonfire    danisnotonfire      https://www.youtube.com/user/danisnotonfire
# kickthepj           kickthepj         kickthepj           https://www.youtube.com/user/KickThePj
# catrific            catrific          catrific            https://www.youtube.com/user/catrific
# tayzonday           TayZonday         tayzonday           https://www.youtube.com/user/TayZonday
# marcusbutler        MarcusButler      marcusbutler        https://www.youtube.com/user/MarcusButlerTV

# benjamincook        benjamin_cook     benjamin_cook       https://www.youtube.com/user/ninebrassmonkeys
# olgakay             OlgaKay           olgakay             https://www.youtube.com/user/olgakay
# hannahhart          harto             harto               https://www.youtube.com/user/MyHarto
# anthonypadilla      smoshanthony      anthonypadilla      https://www.youtube.com/user/AnthonyPadilla
# juliansmith         JulianWasHere     julianwashere       https://www.youtube.com/user/juliansmith87

# amazingphil         AmazingPhil       amazingphil         https://www.youtube.com/user/AmazingPhil
# sampepper           sampepper         itssampepper        https://www.youtube.com/user/OFFICIALsampepper

####CELEBRITIES
# blakelively         blakelively         blakelively             https://www.youtube.com/channel/UCKMKpIg3ZXn-7_xr4RAuQjA
# leonardodicaprio    LeoDiCaprio         leonardodicaprio        https://www.youtube.com/channel/UCc5HhOHhTKOMK_ta2lqtKgw
# emmastone           EmmaStoneWeb        emmastone_official_     none
# jayz                JayZClassicBars     shawn.carter            https://www.youtube.com/user/JayZVEVO
# ellendegeneres      TheEllenShow        theellenshow            https://www.youtube.com/user/TheEllenShow

# sandrabullock       sbullockweb         sandrabullockig         none
# ashleygreene        AshleyMGreene       ashleygreene            https://www.youtube.com/channel/UCEHOQe7Kk_4F6LvAcPp1SKQ
# natalieportman      PortmanUpdate       natalieportmanlove      https://www.youtube.com/channel/UC7M0_DE8EhWTpSgRqiuToCA
# jenniferlawrence    MsJenniferLaw       jenniferlawrencepx      https://www.youtube.com/channel/UC1SBXt6T5VT12_UFUupLWXA
# katebosworth        katebosworth        katebosworth            https://www.youtube.com/channel/UC-jXKCYtzcMjBr8f66hyEvA

# camerondiaz         CameronDiaz         camerondiaz             https://www.youtube.com/channel/UC9k-NlU7gjr8F0HlCTAWlXQ
# milakunis           Milla_Kunis         milakunis______         https://www.youtube.com/channel/UCl6qhIrV6It5TCyjS6Cq2lg
# floydmayweather     FloydMayweather     floydmayweather         https://www.youtube.com/user/FloydMayweather
# reesewitherspoon    RWitherspoon        reesewitherspoon        https://www.youtube.com/channel/UCE20hbhrnFW3bhndXukSxAg
# kateupton           KateUpton           kateupton               https://www.youtube.com/channel/UCyXW3LwGzBo1gQ8DOg7L5Nw

# peterdinklage       Peter_Dinklage      peterdinklage           none





# katyperry           katyperry           katyperry               https://www.youtube.com/user/KatyPerryVEVO
# barackobama         BarackObama         barackobama             https://www.youtube.com/user/BarackObamadotcom
# taylorswift         taylorswift13       taylorswift             https://www.youtube.com/user/TaylorSwiftVEVO
# ladygaga            ladygaga            ladygaga                https://www.youtube.com/user/LadyGagaVEVO
# justintimberlake    jtimberlake         justintimberlake        https://www.youtube.com/user/justintimberlakeVEVO

# brittneyspears      britneyspears       britneyspears           https://www.youtube.com/user/BritneySpearsVEVO
# kimkardashianwest   KimKardashian       kimkardashian           none
# shakira             shakira             shakira                 https://www.youtube.com/user/shakiraVEVO
# jenniferlopez       JLo                 jlo                     https://www.youtube.com/user/JenniferLopez
# selenagomez         selenagomez         selenagomez             https://www.youtube.com/user/SelenaGomezVEVO

# arianagrande        ArianaGrande        arianagrande            https://www.youtube.com/user/ArianaGrandeVevo
# demilovato          ddlovato            ddlovato                https://www.youtube.com/user/DemiLovatoVEVO
# jimmyfallon         jimmyfallon         jimmyfallon             https://www.youtube.com/user/latenight
# lebronjames         KingJames           kingjames               none
# adele               OfficialAdele       adele                   https://www.youtube.com/user/AdeleVEVO

# brunomars           BrunoMars           brunomars               https://www.youtube.com/user/ElektraRecords
# aliciakeys          aliciakeys          aliciakeys              https://www.youtube.com/user/aliciakeysVEVO
# mileyraycyrus       MileyCyrus          mileycyrus              https://www.youtube.com/user/MileyCyrusVEVO
# nickiminaj          NICKIMINAJ          nickiminaj              https://www.youtube.com/user/NickiMinajAtVEVO
# emmawatson          EmWatson            emmawatson              none

# neilpatrickharris   ActuallyNPH         nph                     https://www.youtube.com/channel/UCk_Dx67t-aXqw9uQLVX-UCQ
# davidguetta         davidguetta         davidguetta             https://www.youtube.com/user/davidguettavevo
# conanobrien         ConanOBrien         teamcoco                https://www.youtube.com/user/teamcoco
# khloekardashian     KhloeKardashian     kloekardashianthegirl   https://www.youtube.com/channel/UCJy0RHFC64EC-kqWOfhCb_g
# kourtneykardashian  kourtneykardashian  kourtneykardash         https://www.youtube.com/channel/UCXIf9YuOaiCSn2r4P5SZ_Zw

# christinaaguilera   xtina               xtina                   https://www.youtube.com/user/CAguileraVEVO
# beyonce             Beyonce             beyonce                 https://www.youtube.com/user/beyonceVEVO
# oprahwinfrey        Oprah               oprah                   https://www.youtube.com/channel/UCqL0gza-KJcuVe3e0FCbM8Q
# johnnydepp          realdepp            johnnydepp.oficial      https://www.youtube.com/channel/UCPP2obRMCcnokAqR4NzMuwQ
# scarlettjohansson   ScarlettJOnline     scarlettjohanssonaddict https://www.youtube.com/channel/UCuaGAGmxgipdJEOrYaMT0Nw

# madonna             Madonna             madonna                 https://www.youtube.com/user/madonna
# tomhanks            tomhanks            tomhanks                https://www.youtube.com/user/tomhankschannel
# jessicaalba         jessicaalba         jessicaalba             https://www.youtube.com/channel/UCPJorwl_vxgiNni6Mas8a7A
# meganfox            meganfox            dailymeganfox           https://www.youtube.com/channel/UCsN68XRv5dVieQizOcLyzOg
# tigerwoods          TigerWoods          TigerWoods              none 


#####TV SHOWS

# lastweektonight                     LastWeekTonight     lastweektonight            https://www.youtube.com/user/LastWeekTonight
# gameofthrones                       GameOfThrones       gameofthrones              https://www.youtube.com/user/GameofThrones
# bettercallsaul                      BetterCallSaul      bettercallsaulamc          https://www.youtube.com/channel/UCCab9hOn5MELbKB__AOU3RQ
# orangeisthenewblack                 OITNB               oitnb                      none
# empire                              EmpireFox           empirefox                  https://www.youtube.com/user/EMPIREonFOX

# howimetyourmother                   OfficialHIMYM       himym_official             none
# madmen                              MadMen_AMC          madmen_amc                 none 
# theamericans                        TheAmericansFX      theamericansfx             https://www.youtube.com/user/TheAmericansFX
# thetonightshow                      FallonTonight       fallontonight              https://www.youtube.com/user/latenight
# truedetective                       TrueDetective       truedetective              none

# justified                           JustifiedFX         justifiedfx                none
# sense8                              sense8              sense8                     https://www.youtube.com/channel/UC7Vsk1omEqLSbxKdnSqYvXw
# izombie                             CWiZombie           thecwizombie               https://www.youtube.com/channel/UCtgIz5m-kWXdHOPYLp5Banw
# theflash                            CW_TheFlash         cwtheflash                 https://www.youtube.com/user/barryallentheflash1
# thebachelor                         BachelorABC         bachelorabc                https://www.youtube.com/channel/UCXyOZBTth57gdz6k7KPHOsw

# suits                               Suits_USA           suits_usa                  https://www.youtube.com/user/SuitsonUSA
# theellenshow                        TheEllenShow        theellenshow               https://www.youtube.com/user/TheEllenShow
# greysanatomy                        GreysABC            greysabc                   https://www.youtube.com/channel/UC5lWD_N9kq8IdWzLOdy5fow
# thewalkingdead                      WalkingDead_AMC     amcthewalkingdead          none
# americanhorrorstory                 AmericanHorrorStory americanhorrorstory        https://www.youtube.com/user/qwerty19107

# sharktank                           ABCSharkTank        sharktankabc               none
# gotham                              Gotham              gothamonfox                https://www.youtube.com/user/GothamFOX
# thegoodwife                         TheGoodWife_CBS     thegoodwife_cbs            https://www.youtube.com/user/thegoodwife
# thebigbangtheory                    BigBang_CBS         bigbangtheory_cbs          https://www.youtube.com/user/thebigbangtheory
# theblacklist                        NBCBlacklist        nbcblacklist               https://www.youtube.com/user/NBCBlacklist

# howtogetawaywithmurder              HowToGetAwayABC     howtogetawaywithmurder     https://www.youtube.com/channel/UC-GfszUQ-kV4iMmk5W67mAQ
# thevoice                            NBCTheVoice         nbcthevoice                https://www.youtube.com/user/NBCTheVoice
# bachelorette                        BacheloretteABC     bacheloretteabc            none
# scandal                             ScandalABC          scandalabc                 https://www.youtube.com/channel/UCeGLGp4pnTqL64jY3p0daXA
# downtonabbey                        DowntonAbbey        downtonabbey_official      https://www.youtube.com/channel/UCSm1kNzkDuHqirriGJMZHJQ

# dancingwiththestars                 DancingABC          dancingabc                 https://www.youtube.com/user/ABCDWTS
# americanidol                        AmericanIdol        americanidol               https://www.youtube.com/user/americanidol
# thementalist                        Mentalist_CBS       mentalist_cbs              https://www.youtube.com/user/CBSTheMentalist
# houseofcards                        HouseofCards        houseofcards               https://www.youtube.com/channel/UCos_6s_sPNVZMA2YHeJ7nHg
# transparent                         transparent_tv      transparentamazon          https://www.youtube.com/channel/UCDHUIuNK2PG9UqXsxoLJxsw

# louie                               LouieFX             louieonfx                  none
# community                           CommunityTV         communitytv                none
# parksandrecreation                  parksandrecnbc      nbcparksandrec             https://www.youtube.com/user/nbcParksandRec
# sonsofanarchy                       SonsofAnarchy       soafx                      https://www.youtube.com/channel/UCp-omzXg5JOqQJQErHhUhrw
# brooklynninenine                    Brooklyn99FOX       brooklyn99fox              none

# janethevirgin                       CWJaneTheVirgin     cwjanethevirgin            none
# fargo                               FargoFX             fargo                      none
# saturdaynightlive                   nbcsnl              nbcsnl                     https://www.youtube.com/user/SaturdayNightLive
# mrrobot                             whoismrrobot        whoismrrobot               https://www.youtube.com/channel/UCX5R2xqZWND8nJqGTvel3nw
# themindyproject                     TheMindyProject     mindyprojecthulu           none

# newgirl                             NewGirlonFOX        newgirlfox                 none 
# scorpion                            ScorpionCBS         scorpioncbs                https://www.youtube.com/user/CBSScorpion
# modernfamily                        ModernFam           modernfamily               none 

# #######Sports

# realmadrid                      realmadrid        realmadrid            https://www.youtube.com/user/realmadridcf
# dallascowboys                   dallascowboys     dallascowboys         https://www.youtube.com/channel/UCdjR8pv3bU7WLRshUMwxDVw
# newyorkyankees                  Yankees           yankees               https://www.youtube.com/channel/UCQNgE6-Q5OBvLzhyAmWZItQ
# barcelona                       FCBarcelona       fcbarcelona           https://www.youtube.com/user/fcbarcelona
# manchesterunited                ManUtd            manchesterunited      https://www.youtube.com/channel/UCKHRBMEiy-GuV-F7JQbJWLg

# losangeleslakers                Lakers            lakers                https://www.youtube.com/user/lakersnationdotcom
# newenglandpatriots              Patriots          patriots              https://www.youtube.com/channel/UCF54f0UTZ2ctCDs5yJjDblQ
# newyorkknicks                   nyknicks          nyknicks              https://www.youtube.com/user/nyknicks
# losangelesdodgers               Dodgers           dodgers               https://www.youtube.com/channel/UCg_8DdhmyMMxa8Xwbcmm-_w
# washingtonredskins              Redskins          redskins              https://www.youtube.com/user/redskinsdotcom

# bayernmunich                    FCBayern          fcbayern              https://www.youtube.com/user/fcbayern
# bostonredsox                    RedSox            redsox                https://www.youtube.com/channel/UC3FcTH3wcqNWHx4T6iICz_g
# newyorkgiants                   Giants            nygiants              https://www.youtube.com/channel/UCnEubDTRusG-qvohSNyCuWg
# chicagobulls                    chicagobulls      chicagobulls          https://www.youtube.com/user/chicagobullsofficial
# sanfranciscogiants              SFGiants          sfgiants              none

# houstontexans                   HoustonTexans     houstontexans         https://www.youtube.com/channel/UC3fjWR24Ej6EfvMv6Hqq28g
# chicagocubs                     Cubs              cubs                  https://www.youtube.com/channel/UCbtkUT23QOxQb1w1aP-tRIA
# newyorkjets                     nyjets            nyjets                https://www.youtube.com/channel/UCNdo59IgJRskCLP7FBWqe6w
# philadelphiaeagles              Eagles            philadelphiaeagles    https://www.youtube.com/channel/UCaogx6OHpsGg0zuGRKsjbtQ
# bostonceltics                   celtics           celtics               https://www.youtube.com/user/bostonceltics

# chicagobears                    ChicagoBears      chicagobears          https://www.youtube.com/channel/UCP0Cdc6moLMyDJiO0s-yhbQ
# losangelesclippers              LAClippers        laclippers            https://www.youtube.com/user/clippers1970
# sanfrancisco49ers               49ers             49ers                 https://www.youtube.com/user/sanfrancisco49ers
# baltimoreravens                 Ravens            ravens                https://www.youtube.com/user/baltimoreravens
# brooklynnets                    BrooklynNets      brooklynnets          https://www.youtube.com/user/NBANets

# denverbroncos                   Broncos           broncos               https://www.youtube.com/channel/UCe6XsNDeY3pxqXJMc_iheUA
# indianapoliscolts               Colts             colts                 none
# stlouiscardinals                Cardinals         cardinals             https://www.youtube.com/channel/UCYPeuBXCeFOq5QfhEnUfr8A
# greenbaypackers                 packers           packers               https://www.youtube.com/channel/UC_C4jeUvhqbsOFCCMql5sHg
# manchestercity                  MCFC              mcfcofficial          https://www.youtube.com/user/mcfcofficial

# chelsea                         ChelseaFC         chelseafc             https://www.youtube.com/user/chelseafc
# ferrari                         Ferrari           ferrariusa            https://www.youtube.com/user/ferrariworld
# newyorkmets                     Mets              mets                  none
# pittsburghsteelers              steelers          steelers              https://www.youtube.com/channel/UCR6rBAe6fuKAJjdg4dbAcqg
# seattleseahawks                 Seahawks          seahawks              https://www.youtube.com/user/seahawksdotcom

# arsenal                         Arsenal           arsenal               https://www.youtube.com/user/ArsenalTour
# goldenstatewarriors             warriors          warriors              https://www.youtube.com/user/GoldenStateWarriors
# losangelesangelsofanaheim       Angels            angels                none
# miamidolphins                   MiamiDolphins     miamidolphins         https://www.youtube.com/channel/UCdbljRu3B3WIYliBJat_wsg
# torontomapleleafs               MapleLeafs        mapleleafs            https://www.youtube.com/user/torontomapleleafs

# washingtonnationals             Nationals         nationals             https://www.youtube.com/channel/UCQh28Q2ew4jVoNcDyRygeBw
# carolinapanthers                Panthers          panthers              https://www.youtube.com/channel/UCDmv5BcYE3hQW354jk9W0Cg
# houstonrockets                  HoustonRockets    houstonrockets        https://www.youtube.com/channel/UCmjAHvW8SC7vmhCFomfyV7Q
# philadelphiaphillies            Phillies          phillies              https://www.youtube.com/channel/UCQh91_NPlNSpWWfqcVLUMTQ
# tampabaybuccaneers              TBBuccaneers      tbbuccaneers          https://www.youtube.com/channel/UC_DXo-lcvFwMWCYNgHP4_tg

# texasrangers                    Rangers           rangers               none
# miamiheat                       MiamiHEAT         miamiheat             https://www.youtube.com/user/miamiheat
# tennesseetitans                 Titans            tennesseetitans       https://www.youtube.com/channel/UCZIg4NlOuW_ReCVVZ64eLlw
# atlantabraves                   Braves            braves                https://www.youtube.com/channel/UCglKlWno0PXtVhWWQLyQyPQ
# minnesotavikings                Vikings           vikings               https://www.youtube.com/channel/UCSb9A1uBRGUHfSyKCrhfXYA

# arizonacardinals                AZCardinals       azcardinals           https://www.youtube.com/channel/UC9YrTlASDs12N2SosBvl8tQ

# ####MUSIC

# onedirection            onedirection        onedirection          https://www.youtube.com/user/OneDirectionVEVO
# katyperrymusic               katyperry           katyperry             https://www.youtube.com/user/KatyPerryVEVO
# beyoncemusic                 Beyonce             beyonce               https://www.youtube.com/user/beyonceVEVO
# taylorswiftmusic             taylorswift13       taylorswift           https://www.youtube.com/user/TaylorSwiftVEVO
# justintimberlakemusic        jtimberlake         justintimberlake      https://www.youtube.com/user/justintimberlakeVEVO

# iggyazalea              IGGYAZALEA          thenewclassic         https://www.youtube.com/user/iggyazaleamusicVEVO
# arianagrandemusic            ArianaGrande        arianagrande          https://www.youtube.com/user/ArianaGrandeVevo
# mileycyrus                   MileyCyrus          mileycyrus            https://www.youtube.com/user/MileyCyrusVEVO
# pharrelwilliams         Pharrell            pharrell              https://www.youtube.com/user/PharrellWilliamsVEVO
# eminem                  Eminem              eminem                https://www.youtube.com/user/EminemVEVO

# lorde                   lordemusic          lordemusic            https://www.youtube.com/user/LordeVEVO
# lukebryan               LukeBryanOnline     lukebryan             https://www.youtube.com/user/LukeBryanVEVO
# samsmith                samsmithworld       samsmithworld         https://www.youtube.com/user/SamSmithWorldVEVO
# johnlegend              johnlegend          johnlegend            https://www.youtube.com/user/johnlegendVEVO
# onerepublic             OneRepublic         onerepublic           https://www.youtube.com/user/OneRepublicVEVO

# drake                   Drake               leaderofnewschool     https://www.youtube.com/user/DrakeVEVO
# jasonderulo             jasonderulo         jasonderulo           https://www.youtube.com/user/JasonDerulo
# justinbieber            justinbieber        justinbieber          https://www.youtube.com/user/JustinBieberVEVO
# imaginedragons          imaginedragons      imaginedragons        https://www.youtube.com/user/ImagineDragonsVEVO
# floridageorgialine      FLAGALine           flagaline             https://www.youtube.com/user/FlaGeorgiaLineVEVO

# nickiminajmusic              NICKIMINAJ          nickiminaj            https://www.youtube.com/user/NickiMinajAtVEVO
# 5secondsofsummer        5SOS                5sos                  https://www.youtube.com/user/5sosvevo
# ladygagamusic                ladygaga            ladygaga              https://www.youtube.com/user/LadyGagaVEVO
# pitbull                 pitbull             pitbull               https://www.youtube.com/user/PitbullVEVO
# brunomarsmusic               BrunoMars           brunomars             https://www.youtube.com/user/ElektraRecords

# jasonaldean             Jason_Aldean        jasonaldean           https://www.youtube.com/user/Jason_Aldean
# maroon5                 maroon5             maroon5               https://www.youtube.com/user/Maroon5VEVO
# chrisbrown              chrisbrown          chrisbrownofficial    https://www.youtube.com/user/ChrisBrownVEVO
# meghantrainor           Meghan_Trainor      meghan_trainor        https://www.youtube.com/user/MeghanTrainorVEVO
# bastille                bastilledan         bastilledan           https://www.youtube.com/user/BastilleVEVO

# avicii                  Avicii              avicii                https://www.youtube.com/user/AviciiOfficialVEVO
# magic                   ournameisMAGIC      ournameismagic        https://www.youtube.com/user/ournameismagicVEVO
# demilovatomusic              ddlovato            ddlovato              https://www.youtube.com/user/DemiLovatoVEVO
# blakeshelton            blakeshelton        blakeshelton          https://www.youtube.com/user/blakeshelton
# coldplay                coldplay            coldplay              https://www.youtube.com/user/ColdplayVEVO

# charlixcx               charli_xcx          charli_xcx            https://www.youtube.com/user/officialcharlixcx
# nicoandvinz             NicoandVinz         nicoandvinz           https://www.youtube.com/user/envymusicchannel
# therollingstones        RollingStones       therollingstones      https://www.youtube.com/user/TheRollingStones
# shakiramusic                 shakira             shakira               https://www.youtube.com/user/shakiraVEVO
# passenger               passengermusic      passengermusic        https://www.youtube.com/user/passengermusic

# brantleygilbert         BrantleyGilbert     brantleygilbert       https://www.youtube.com/user/BrantleyGilbertVEVO
# elliegoulding           elliegoulding       elliegoulding         https://www.youtube.com/user/EllieGouldingVEVO
# ericchurch              ericchurch          ericchurchmusic       https://www.youtube.com/user/EricChurchVEVO
# idinamenzel             idinamenzel         idinamenzel           https://www.youtube.com/user/Idinamenzel
# selenagomezmusic             selenagomez         selenagomez           https://www.youtube.com/user/SelenaGomezVEVO

# calvinharris            CalvinHarris        calvinharris          https://www.youtube.com/user/CalvinHarrisVEVO
# michaelbuble            michaelbuble        michaelbuble          https://www.youtube.com/user/MichaelBubleTV
# michaeljackson          michaeljackson      michaeljackson        https://www.youtube.com/user/michaeljacksonVEVO
# britneyspearsmusic           britneyspears       britneyspears         https://www.youtube.com/user/BritneySpearsVEVO
# kellyclarkson           kelly_clarkson      kellyclarkson         https://www.youtube.com/user/kellyclarksonVEVO

# christinaaguileramusic       xtina               xtina                 https://www.youtube.com/user/CAguileraVEVO

# #####Food

# allrecipes              Allrecipes      allrecipes                https://www.youtube.com/user/allrecipes
# cookingdotcom           CookingCom      cookingcom                https://www.youtube.com/user/cookingcom
# foodnetwork             FoodNetwork     foodnetwork               https://www.youtube.com/user/FoodNetworkTV
# thekitchn               thekitchn       thekitchn                 https://www.youtube.com/channel/UCuNKgYLb0wOoMvclzSlBvbQ
# opentable               OpenTable       opentable                 None

# tasteofhome             tasteofhome     tasteofhome               https://www.youtube.com/user/tasteofhome
# epicurious              epicurious      epicurious                https://www.youtube.com/user/epicuriousdotcom
# grubhub                 GrubHub         grubhub                   https://www.youtube.com/user/grubhub
# seamless                Seamless        eatseamless               https://www.youtube.com/user/eatseamless
# yummly                  yummly          yummly                    https://www.youtube.com/user/Yummly1

# huffingtonpostfood      HuffPostFood    huffpostfood              None
# fooddotcom              Fooddotcom      fooddotcom                None
# bonappetit              bonappetit      bonappetitmag             https://www.youtube.com/user/BonAppetitDotCom
# weightwatchers          WeightWatchers  weightwatchers            https://www.youtube.com/user/WeightWatchers
# foodandwine             FoodAndWineMag  foodandwine               https://www.youtube.com/user/foodandwinevideo

# thechew                 thechew         abcthechew                https://www.youtube.com/channel/UC-Hz_loYacm45SBtSVA0lRA
# americastestkitchen     TestKitchen     testkitchen               https://www.youtube.com/user/americastestkitchen
# ironchefamerica         IronChefAmerica ironchefamericacuisine    https://www.youtube.com/channel/UCoag6CfTHLeHuqtCpvo7o7Q

# Diners, Drive-ins and Dives       
# Cake Boss       
# Cupcake Wars        
# Come Dine Witth Me        
# Cutthroat Kitchen       
# Bizarre Foods       
# Hells Kitchen        
# Chopped       
# Top Chef        
# The Rachael Ray Show        
# Kitchen Nightmares        
# Bar Rescue        


# ####TRAVEL

# budgettravel          BudgetTravel    budgettravel            None
# afar                  AFARmedia       afarmedia               None
# travelandleisure      TravelLeisure   travelandleisure        None
# condenasttraveler     CNTraveler      cntraveler              None
# geographical          GeographicalMag geographical_magazine   None

# nationalgeographic    NatGeo          natgeotravel            None
# wanderlust            WanderlustFest  wanderlustfest          None

# Cruise Travel       
# Cruising World        
# Coastal Living        
# Caribbean Living        
# Yachting        
# Destinations        
# Pathfinders Travel        
# Africa Geographic       
# Backpacker        
# Outside       
# Camping Life        
# Cabin Life        
# American Road       
# Trailer Life        
# Outpost Magazine        
# The Expeditioner        
# Suitcase  