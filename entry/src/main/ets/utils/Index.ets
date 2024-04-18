/**
 * @param {function} func
 * @param {number} delay
 * @returns
 */
export function debounce(func: (...args: any[]) => void, delay = 300) {
  let timer = -1
  return function (...args: any[]) {
    if (timer > 1) {
      clearTimeout(timer);
    }
    timer = setTimeout(() => {
      func(...args);
    }, delay);
  };
}

/**
 * @param {object} source
 * @returns {object}
 */
export function deepClone(source: object) {
  const targetObj = source.constructor === Array ? [] : ({} as any);
  Object.keys(source).forEach((keys) => {
    const value = (source as any)[keys];
    if (value && typeof value === "object") {
      targetObj[keys] = deepClone(value);
    } else {
      targetObj[keys] = value;
    }
  });
  return targetObj;
}