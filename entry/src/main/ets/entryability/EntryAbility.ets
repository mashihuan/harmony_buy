import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import AddressModel from '../model/AddressModel';
import CartModel from '../model/CartModel';
import OrderGoodsModel from '../model/OrderGoodsModel';
import OrderModel from '../model/OrderModel';
import PreferencesUtil from '../utils/PreferencesUtil';
import RdbUtil from '../utils/RdbUtil';

export default class EntryAbility extends UIAbility {
  async onCreate(want, launchParam) {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    // 加载首选项
    await PreferencesUtil.getPreferences(this.context)
    // 加载RdbStore
    await RdbUtil.getRdbStore(this.context)
    await RdbUtil.createTable(CartModel.getCreateTableSql())
    await RdbUtil.createTable(AddressModel.getCreateTableSql())
    await RdbUtil.createTable(OrderModel.getCreateTableSql())
    await RdbUtil.createTable(OrderGoodsModel.getCreateTableSql())
  }

  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
    // 修改状态栏背景色
    let windowClass = null
    let SystemBarProperties = {
      statusBarColor: '#45B934',
      statusBarContentColor: '#ffffff',
    };
    windowStage.getMainWindow((err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to obtain the main window. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      windowClass = data
      windowClass.setSystemBarProperties(SystemBarProperties, err => {
        if (err.code) {
          hilog.error(0x0000, 'testTag', 'Failed to set the system bar properties. Cause: ' + JSON.stringify(err));
          return;
        }
        hilog.info(0x0000, 'testTag', 'Succeeded in setting the setSystemBarProperties.');
      })
    })

    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground() {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground() {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
