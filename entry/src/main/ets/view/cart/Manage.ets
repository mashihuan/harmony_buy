import { Constants } from '../../common/Constants'

@Extend(Text) function textStyle() {
  .fontSize(15)
  .fontColor($r('app.color.color_text'))
}

@Component
export default struct CartManage {
  @Link isEdit: boolean

  changeEditStatus() {
    this.isEdit = !this.isEdit
  }

  build() {
    Row() {
      if (this.isEdit) {
        Text('完成')
          .textStyle()
          .onClick(() => this.changeEditStatus())
      } else {
        Text('管理')
          .textStyle()
          .onClick(() => this.changeEditStatus())
      }
    }
    .width('100%')
    .height(36)
    .padding({ right: Constants.SPACE_8 })
    .justifyContent(FlexAlign.End)
    .backgroundColor('#fff')
  }
}