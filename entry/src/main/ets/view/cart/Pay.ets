import { Constants } from '../../common/Constants'
import CartItem from '../../viewmodel/CartItem'

@Extend(Button) function buttonStyle() {
  .height(30)
  .margin({ left: 22 })
  .fontSize(13)
}

@Component
export default struct CartPay {
  @Link isEdit: boolean
  @Link selectedIds: number[]
  @Link cartList: CartItem[]
  @Prop totalNumber: number
  @Prop totalPrice: number
  onSubmit: () => void
  onDelete: () => void

  build() {
    Row() {
      Row() {
        CheckboxGroup({ group: 'cart' })
          .selectAll(this.selectedIds.length === this.cartList.length)
          .selectedColor($r('app.color.color_primary'))
          .onChange(val => {
            this.selectedIds = val.name.map(item => Number(item))
          })
        Text('全选')
          .fontSize(14)
          .fontColor($r('app.color.color_text'))
      }

      if (!this.isEdit) {
        Row() {
          Text('合计：')
            .fontSize(14)
            .fontColor($r('app.color.color_text'))
          Text('¥' + this.totalPrice.toFixed(1))
            .fontSize(14)
            .fontColor($r('app.color.color_new_price'))
          Button(`结算(${this.totalNumber}件)`)
            .enabled(true)
            .buttonStyle()
            .backgroundColor($r('app.color.bg_primary'))
            .onClick(() => {
              this.onSubmit()
            })
        }
      } else {
        Button(`删除`)
          .enabled(true)
          .buttonStyle()
          .backgroundColor($r('app.color.color_danger'))
          .onClick(() => {
            this.onDelete()
          })
      }
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
    .height(55)
    .padding({ left: Constants.SPACE_12, right: Constants.SPACE_12 })
    .backgroundColor($r('app.color.color_bg_container'))
    .border({ width: { bottom: 0.5 }, color: '#e5e5e5' })
  }
}