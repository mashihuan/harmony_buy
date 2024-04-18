import relationalStore from '@ohos.data.relationalStore';
import { ColumnInfo, ColumnType } from '../common/ColumnInfo';
import { Constants } from '../common/Constants';

class RdbUtil {
  store: relationalStore.RdbStore

  async getRdbStore(context) {
    const config: relationalStore.StoreConfig = {
      name: Constants.RDB_NAME,
      securityLevel: relationalStore.SecurityLevel.S1
    }
    try {
      this.store = await relationalStore.getRdbStore(context, config)
    } catch (err) {
      console.error('testTag', `Failed to get RdbStore. Code:${err.code}, message:${err.message}`)
    }
  }

  async createTable(createSql: string) {
    try {
      await this.store.executeSql(createSql)
    } catch (err) {
      console.error('testTag', `Failed to executeSql. Code:${err.code}, message:${err.message}`)
    }
  }

  async insert(table: string, data: any, columns: ColumnInfo[]) {
    try {
      const values = this.buildValuesBucket(data, columns)
      return this.store.insert(table, values)
    } catch (err) {
      console.error('testTag', `Failed to insert data. Code:${err.code}, message:${err.message}`)
    }
  }

  async batchInsert(table: string, values: relationalStore.ValuesBucket[]) {
    try {
      return this.store.batchInsert(table, values)
    } catch (err) {
      console.error('testTag', `Failed to insert data. Code:${err.code}, message:${err.message}`)
    }
  }

  async update(predicates: relationalStore.RdbPredicates, data: any, columns: ColumnInfo[]) {
    try {
      const values = this.buildValuesBucket(data, columns)
      return this.store.update(values, predicates)
    } catch (err) {
      console.error('testTag', `Failed to update data. Code:${err.code}, message:${err.message}`)
    }
  }

  async delete(predicates: relationalStore.RdbPredicates) {
    try {
      return this.store.delete(predicates)
    } catch (err) {
      console.error('testTag', `Failed to delete data. Code:${err.code}, message:${err.message}`)
    }
  }

  async query(predicates: relationalStore.RdbPredicates, columns: ColumnInfo[]) {
    try {
      const result = await this.store.query(predicates, columns.map(column => column.columnName))
      return this.parseResultSet(result, columns)
    } catch (err) {
      console.error('testTag', `Failed to query data. Code:${err.code}, message:${err.message}`)
    }
  }

  parseResultSet(result: relationalStore.ResultSet, columns: ColumnInfo[]) {
    const arr = []
    if (result.rowCount <= 0) {
      return arr
    }
    while (!result.isAtLastRow) {
      result.goToNextRow()
      const obj = {}
      columns.forEach(column => {
        let val = null
        switch (column.type) {
          case ColumnType.LONG:
            val = result.getLong(result.getColumnIndex(column.columnName))
            break;
          case ColumnType.DOUBLE:
            val = result.getDouble(result.getColumnIndex(column.columnName))
            break;
          case ColumnType.STRING:
            val = result.getString(result.getColumnIndex(column.columnName))
            break;
          case ColumnType.BLOB:
            val = result.getBlob(result.getColumnIndex(column.columnName))
            break;
          default:
            break;
        }
        obj[column.name] = val
      })
      arr.push(obj)
    }
    return arr
  }

  buildValuesBucket(data: any, columns: ColumnInfo[]): relationalStore.ValuesBucket {
    const values = {}
    columns.forEach(column => {
      const val = data[column.name]
      if (typeof val !== 'undefined') {
        values[column.columnName] = val
      }
    })
    return values
  }
}

export default new RdbUtil