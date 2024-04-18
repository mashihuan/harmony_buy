import { Constants } from '../common/Constants'
import NavigationBar from '../components/NavigationBar'

type InfoType = 'image' | 'text'

class InfoItem {
  label: ResourceStr
  value: ResourceStr
  type: InfoType
}

@Styles function pressedStyles() {
  .backgroundColor('#fff')
}

@Entry
@Component
struct PersonalData {
  infoList: InfoItem[] = [
    { label: '头像', value: $r('app.media.avatar'), type: 'image' },
    { label: '昵称', value: '食屎不忘拉屎人', type: 'text' },
    { label: '手机号', value: '15955265378', type: 'text' },
  ]

  build() {
    Column() {
      NavigationBar({ title: '个人资料' })
      Column() {
        Row() {
        }
        .width('100%')
        .height(70)
        .backgroundColor($r('app.color.bg_primary'))

        List() {
          ForEach(this.infoList, (info: InfoItem) => {
            ListItem() {
              Row() {
                Text(info.label)
                  .margin({ right: 5 })
                  .fontColor($r('app.color.color_text'))
                Blank()
                if (info.type === 'image') {
                  Image(info.value)
                    .width(55)
                    .height(55)
                    .borderRadius(30)
                } else {
                  TextInput({ text: info.value })
                    .layoutWeight(1)
                    .padding({ right: 16 })
                    .textAlign(TextAlign.End)
                    .fontColor($r('app.color.color_text'))
                    .backgroundColor('#fff')
                    .stateStyles({
                      pressed: pressedStyles,
                    })
                }
                Image($r('app.media.arrow_right'))
                  .width(20)
                  .fillColor('#bcbcbc')
              }
              .width('100%')
            }
            .height(info.type === 'image' ? 88 : 66)
            .padding({ right: Constants.SPACE_12, left: Constants.SPACE_12 })
            .border({ width: { bottom: 1 }, style: BorderStyle.Solid, color: '#f4f4f4' })
          })
        }
        .margin({ top: -40, right: 16, left: 16 })
        .padding({ right: Constants.SPACE_5, left: Constants.SPACE_5 })
        .backgroundColor($r('app.color.color_bg_container'))
        .borderRadius(5)
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.color_bg_layout'))
  }
}