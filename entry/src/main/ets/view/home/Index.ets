import GoodsList from '../../components/GoodsList'
import GoodsModel from '../../model/GoodsModel'
import GoodsItem from '../../viewmodel/GoodsItem'
import HomeBanner from './Banner'
import HomeGrid from './Grid'
import HomeHeader from './Header'

@Component
export default struct HomeIndex {
  @State newGoodsList: GoodsItem[] = []
  @State freshGoodsList: GoodsItem[] = []
  @State riceGoodsList: GoodsItem[] = []

  aboutToAppear() {
    this.getNewGoodsList()
    this.getFreshGoodsList()
    this.getRiceGoodsList()
  }

  async getNewGoodsList() {
    const res = await GoodsModel.getGoodsByCategory({
      category_id: 1
    })
    this.newGoodsList = res.data.goods || []
  }

  async getFreshGoodsList() {
    const res = await GoodsModel.getGoodsByCategory({
      category_id: 2
    })
    this.freshGoodsList = res.data.goods || []
  }

  async getRiceGoodsList() {
    const res = await GoodsModel.getGoodsByCategory({
      category_id: 3
    })
    this.riceGoodsList = res.data.goods || []
  }

  build() {
    Column() {
      HomeHeader()
      Scroll() {
        Column() {
          HomeBanner()
          HomeGrid()
          GoodsList({ title: '新品尝鲜', banner: $r('app.media.banner_new'), goodsList: $newGoodsList })
          GoodsList({ title: '优质新鲜', banner: $r('app.media.banner_fresh'), goodsList: $freshGoodsList })
          GoodsList({ title: '粮油米面', banner: $r('app.media.banner_rice'), goodsList: $riceGoodsList })
        }
      }
    }
    .width('100%')
    .height('100%')
  }
}