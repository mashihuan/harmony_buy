import router from '@ohos.router'
import Empty from '../components/Empty'
import NavigationBar from '../components/NavigationBar'
import AddressModel from '../model/AddressModel'
import AddressItem from '../viewmodel/AddressItem'

@Entry
@Component
struct Address {
  @State addressList: AddressItem[] = []
  @State from: string = ''

  aboutToAppear() {
    const params: any = router.getParams()
    this.from = params?.from || ''
  }

  onPageShow() {
    this.getAddress()
  }

  async getAddress() {
    const res = await AddressModel.query()
    this.addressList = res || []
  }

  build() {
    Column() {
      NavigationBar({ title: '收货地址' })
      Column() {
        if (this.addressList.length) {
          List() {
            ForEach(this.addressList, (address: AddressItem) => {
              ListItem() {
                Row() {
                  Row() {
                    Column() {
                      Row() {
                        Text(address.name)
                        Text(address.phone)
                          .margin({ left: 10 })
                          .fontSize(14)
                          .fontColor($r('app.color.color_text_tertiary'))
                        if(address.is_default) {
                          Text('默认')
                            .margin({ left: 20 })
                            .fontSize(14)
                            .fontColor($r('app.color.color_primary'))
                        }
                      }

                      Row() {
                        Text(address.area)
                          .margin({ top: 12 })
                          .fontColor($r('app.color.color_text_secondary'))
                      }
                    }
                    .layoutWeight(1)
                    .margin({ right: 16 })
                    .alignItems(HorizontalAlign.Start)
                    .onClick(() => {
                      if(this.from) {
                        AppStorage.SetOrCreate('addressInfo', address)
                        router.back()
                      }
                    })

                    Text('编辑')
                      .fontColor($r('app.color.color_text_secondary'))
                      .onClick(() => {
                        router.pushUrl({
                          url: 'pages/AddressDetail',
                          params: { id: address.id }
                        })
                      })
                  }
                  .width('100%')
                  .padding({ top: 12, right: 8, bottom: 12, left: 8 })
                  .justifyContent(FlexAlign.SpaceBetween)
                  .border({
                    width: { bottom: 1 },
                    style: BorderStyle.Solid,
                    color: $r('app.color.color_border_secondary')
                  })
                }
                .width('100%')
                .padding({ right: 8, left: 8 })
                .backgroundColor($r('app.color.color_bg_container'))
              }
            })
          }
          .width('100%')
          .height('100%')
        } else {
          Empty({ desc: '暂无收货地址...' })
        }
      }
      .layoutWeight(1)

      Row() {
        Button('新增收货地址')
          .width('100%')
          .backgroundColor($r('app.color.bg_primary'))
          .onClick(() => {
            router.pushUrl({
              url: 'pages/AddressDetail',
              params: {
                from: this.from
              }
            })
          })
      }
      .width('100%')
      .padding(16)
      .backgroundColor($r('app.color.color_bg_container'))
      .border({ width: { top: 1 }, style: BorderStyle.Solid, color: $r('app.color.color_border') })
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.color_bg_layout'))
  }
}