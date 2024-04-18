import GoodsList from '../../components/GoodsList'
import NavigationBar from '../../components/NavigationBar'
import GoodsModel from '../../model/GoodsModel'
import GoodsItem from '../../viewmodel/GoodsItem'
import MenuItem from '../../viewmodel/MenuItem'
import MenuList from './MenuList'

@Component
export default struct MenuIndex {
  @State goodsList: GoodsItem[] = []
  @State menuList: MenuItem[] = []

  aboutToAppear() {
    this.getGoodsList()
  }

  async getGoodsList() {
    const res = await GoodsModel.getGoodsByCategory({
      category_id: 4
    })
    this.goodsList = res.data?.goods || []
  }

  build() {
    Column() {
      NavigationBar({ title: '吃什么', hiddenBack: true })
      Scroll() {
        Column() {
          GoodsList({ title: '季节菜谱', goodsList: $goodsList })
          MenuList()
        }
      }
    }
    .width('100%')
    .height('100%')
  }
}