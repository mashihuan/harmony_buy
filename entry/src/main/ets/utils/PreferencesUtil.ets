import dataPreferences from '@ohos.data.preferences'
import { Constants } from '../common/Constants'

class PreferencesUtil {
  preferences: dataPreferences.Preferences

  async getPreferences(context) {
    try {
      this.preferences = await dataPreferences.getPreferences(context, Constants.PREF_NAME)
    } catch (err) {
      console.error('testTag', `Failed to get preferences. Code:${err.code},message:${err.message}`)
    }
  }

  async put(key: string, value: dataPreferences.ValueType) {
    if (this.preferences) {
      try {
        await this.preferences.put(key, value)
        await this.preferences.flush()
      } catch (err) {
        console.error('testTag', `Failed to check the key ${key}. Code:${err.code}, message:${err.message}`)
      }
    }
  }

  async get(key: string, defaultValue: dataPreferences.ValueType) {
    if (this.preferences) {
      try {
        await this.preferences.get(key, defaultValue)
      } catch (err) {
        console.error('testTag', `Failed to get value of ${key}. Code:${err.code}, message:${err.message}`)
      }
    }
  }

  async delete(key: string) {
    try {
      await this.preferences.delete(key)
    } catch (err) {
      console.error('testTag', `Failed to delete the key ${key}. Code:${err.code}, message:${err.message}`)
    }
  }
}

export default new PreferencesUtil