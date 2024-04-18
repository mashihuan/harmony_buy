import router from '@ohos.router'
import { BASE_URL } from '../../common/Config'
import { Constants } from '../../common/Constants'
import BannerModel from '../../model/BannerModel'
import BannerItem from '../../viewmodel/BannerItem'

@Component
export default struct HomeBanner {
  @State bannerList: any[] = []

  aboutToAppear() {
    this.getBanner()
  }

  async getBanner() {
    const res = await BannerModel.requestBanner({})
    this.bannerList = res.data?.banners || []
  }

  build() {
    Row() {
      if(this.bannerList.length) {
        Swiper() {
          ForEach(this.bannerList, (banner: BannerItem) => {
            Image(BASE_URL + banner.url)
              .width('100%')
              .height(165)
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/GoodsDetail',
                  params: { id: banner.goods_id }
                })
              })
          })
        }
        .indicatorStyle({ selectedColor: $r('app.color.color_primary') })
      }
    }
    .width('100%')
    .margin({ top: 85, bottom: Constants.SPACE_12 })
    .padding({ left: Constants.SPACE_16, right: Constants.SPACE_16 })
  }
}