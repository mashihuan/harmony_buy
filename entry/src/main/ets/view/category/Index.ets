import promptAction from '@ohos.promptAction'
import CategoryModel from '../../model/CategoryModel'
import GoodsModel from '../../model/GoodsModel'
import CategoryItem from '../../viewmodel/CategoryItem'
import GoodsItem from '../../viewmodel/GoodsItem'
import CategoryList from './List'
import CategorySearch from './Search'

@Component
export default struct CategoryIndex {
  @Consume @Watch('getGoodsList') categoryId: number
  // @State @Watch('getGoodsList') currentCategoryId: number = 0
  @State categoryList: CategoryItem[] = []
  @State goodsList: GoodsItem[] = []

  aboutToAppear() {
    this.getCategoryList()
  }

  async getCategoryList() {
    const res = await CategoryModel.getCategory()
    this.categoryList = res.data.categorys || []
    this.categoryId = this.categoryList[0]?.id
  }

  async getGoodsList() {
    const res = await GoodsModel.getGoodsByCategory({
      category_id: this.categoryId
    })
    this.goodsList = res.data.goods || []
  }

  build() {
    Column() {
      CategorySearch()
      CategoryList({categoryList: $categoryList, goodsList: $goodsList})
    }
    .height('100%')
  }
}