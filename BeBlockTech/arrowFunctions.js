let orderCount= 0;
const takeOrder = (topping, crustType) => {
  console.log('Order: ' + crustType);
  orderCount = orderCount + 1;
};
function getSubTotal(itemCount) {
  return itemCount * 7.5;
}
const getTax = (orderCount) => {
  return getSubTotal(orderCount) * 0.06;
};
function getTotal() {
  return getSubTotal(orderCount) + getTax(orderCount);
}

takeOrder('chees', 'cryspy');
takeOrder('Bacon', 'thin crust pizza topped with bacon');
takeOrder('tomato', 'filled with cheese');
console.log(getSubTotal(orderCount));
console.log(getTotal());

/*We can refactor this function in three ways. 

1-The most condensed form of the function is known as concise body.
Functions that take a single parameter should not use parentheses. 
The code will still work, but it's better practice to omit the parentheses around single parameters. 
However, if a function takes zero or multiple parameters, parentheses are required.

2-A function composed of a sole single-line block is automatically returned. 
The contents of the block should immediately follow the arrow => and the return keyword can be removed. 
This is referred to as implicit return.

3-A function composed of a sole single-line block does not need brackets.

Example
*/

const multiplyByNineFifths = (celsius) => {
  return celsius * (9/5);
};

const getFahrenheit = (celsius) => {
  return multiplyByNineFifths(celsius) + 32;
};

console.log('The temperature is ' + getFahrenheit(15) + '°F');

//The above code can be expressed in this way

const multiplyByNineFifths = celsius => celsius * (9/5);

const getFahrenheit = celsius => multiplyByNineFifths(celsius) + 32;

console.log('The temperature is ' + getFahrenheit(15) + '°F');
