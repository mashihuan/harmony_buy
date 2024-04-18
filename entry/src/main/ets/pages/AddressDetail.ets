import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import { Constants } from '../common/Constants'
import NavigationBar from '../components/NavigationBar'
import AddressModel from '../model/AddressModel'
import AddressItem from '../viewmodel/AddressItem'

@Extend(Row) function rowStyle() {
  .width('100%')
  .padding({ top: 12, bottom: 12 })
  .border({ width: { bottom: 1 }, style: BorderStyle.Solid, color: $r('app.color.color_border_secondary') })
}

@Extend(Text) function textStyle() {
  .width(70)
  .fontSize(15)
  .fontColor($r('app.color.color_text_tertiary'))
}

@Styles function pressedStyles() {
  .backgroundColor('#fff')
}

@Extend(TextInput) function inputStyle() {
  .layoutWeight(1)
  .backgroundColor('#fff')
  .stateStyles({
    pressed: pressedStyles,
  })
}

@Extend(TextArea) function areaStyle() {
  .layoutWeight(1)
  .backgroundColor('#fff')
  .stateStyles({
    // pressed: pressedStyles,
  })
}

@Entry
@Component
struct AddressDetail {
  @State title: string = '新增地址'
  @State addressId: number = 0
  @State addressInfo: AddressItem = {
    id: 0,
    name: '',
    phone: '',
    area: '',
    detail: '',
    is_default: false
  }
  @State saveLoading: boolean = false
  @State deleteLoading: boolean = false

  aboutToAppear() {
    const params = router.getParams() as any
    if (params && params.id) {
      this.title = '编辑地址'
      this.addressId = params.id
      this.getAddressInfo()
    }
  }

  async getAddressInfo() {
    const res = await AddressModel.queryById(Number(this.addressId))
    const data = res[0] || {}
    this.addressInfo = {
      ...data,
      is_default: data.is_default ? true : false
    }
  }

  onInputChange(name: string, val: string | boolean) {
    this.addressInfo[name] = val
  }

  async onSave() {
    if (!this.addressInfo.name) {
      return promptAction.showToast({ message: '请输入收货人姓名' })
    }
    if (!this.addressInfo.phone) {
      return promptAction.showToast({ message: '请输入联系方式' })
    }
    if (!this.addressInfo.area) {
      return promptAction.showToast({ message: '请输入所在地址' })
    }
    if (!this.addressInfo.detail) {
      return promptAction.showToast({ message: '请输入详细地址' })
    }
    this.saveLoading = true
    if (this.addressId) {
      AddressModel.update(this.addressId,
        {
          ...this.addressInfo,
          is_default: this.addressInfo.is_default ? 1 : 0
        }).then(() => {
        this.handleSaveSuccess()
      }).catch(() => {
        this.saveLoading = false
      })
    } else {
      AddressModel.insert({
        ...this.addressInfo,
        id: undefined,
        is_default: this.addressInfo.is_default ? 1 : 0
      }).then(() => {
        this.handleSaveSuccess()
      }).catch(() => {
        this.saveLoading = false
      })
    }
  }

  async handleSaveSuccess() {
    promptAction.showToast({ message: '保存成功' })
    router.back({
      url: 'pages/Address',
      params: {
        refresh: true
      }
    })
    this.saveLoading = false
  }

  async onDelete() {
    promptAction.showDialog({
      title: '提示',
      message: '确定要删除该地址吗？',
      buttons: [
        { text: '取消', color: $r('app.color.color_text_tertiary') },
        { text: '确定', color: $r('app.color.color_text') },
      ]
    }, (err, data) => {
      if (data.index === 1) {
        this.deleteLoading = true
        AddressModel.delete(this.addressId).then(() => {
          promptAction.showToast({ message: '删除成功' })
          router.back()
          this.deleteLoading = false
        }).catch(() => {
          this.deleteLoading = false
        })
      }
    })
  }

  build() {
    Column() {
      NavigationBar({ title: this.title })
      Column() {
        Row() {
          Text('收货人')
            .textStyle()
          TextInput({ text: this.addressInfo.name, placeholder: '请输入收货人' })
            .inputStyle()
            .onChange(val => this.onInputChange('name', val))
        }
        .rowStyle()

        Row() {
          Text('联系方式')
            .textStyle()
          TextInput({ text: this.addressInfo.phone, placeholder: '请输入联系方式' })
            .inputStyle()
            .type(InputType.PhoneNumber)
            .onChange(val => this.onInputChange('phone', val))
        }
        .rowStyle()

        Row() {
          Text('所在地区')
            .textStyle()
          TextInput({ text: this.addressInfo.area, placeholder: '请输入所在地址' })
            .inputStyle()
            .onChange(val => this.onInputChange('area', val))
        }
        .rowStyle()

        Row() {
          Column() {
            Text('详细地址')
              .textStyle()
          }
          .height(39)

          TextArea({ text: this.addressInfo.detail, placeholder: '请输入详细地址' })
            .height(55)
            .areaStyle()
            .onChange(val => this.onInputChange('detail', val))
        }
        .rowStyle()

        Row() {
          Text('设为默认地址')
            .textStyle()
            .width(100)
            .fontColor($r('app.color.color_text'))
          Blank()
          Toggle({ type: ToggleType.Switch, isOn: this.addressInfo.is_default })
            .selectedColor($r('app.color.color_primary'))
            .onChange(val => this.onInputChange('is_default', val))
        }
        .rowStyle()

        Column() {
          Button() {
            Row() {
              if (this.saveLoading) {
                LoadingProgress().width(40).height(40).color(0xFFFFFF)
              }
              Text('保存').fontColor(0xffffff)
            }.alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .height(40)
          .margin({ bottom: 16 })
          .backgroundColor($r('app.color.bg_primary'))
          .enabled(!this.saveLoading)
          .opacity(this.saveLoading ? 0.4 : 1)
          .onClick(() => this.onSave())

          Button() {
            Row() {
              if (this.deleteLoading) {
                LoadingProgress().width(40).height(40)
              }
              Text('删除收货地址')
                .fontColor($r('app.color.color_text_secondary'))
            }.alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .height(40)
          .backgroundColor(Color.Transparent)
          .fontColor($r('app.color.color_text_secondary'))
          .border({ width: 1, style: BorderStyle.Solid, color: $r('app.color.color_border_secondary') })
          .enabled(!!this.addressId && !this.deleteLoading)
          .opacity((this.addressId && !this.deleteLoading) ? 1 : 0.4)
          .onClick(() => this.onDelete())
        }
        .width('100%')
      }
      .width('100%')
      .padding({ left: Constants.SPACE_16, right: Constants.SPACE_16, bottom: Constants.SPACE_16 })
      .backgroundColor($r('app.color.color_bg_container'))
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.color_bg_layout'))
  }
}