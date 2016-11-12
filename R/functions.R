#this code covers how to write and work with functions in R

library(data.table)

dt.leftJoin= function (left, right, keys, retainOrder= F) 
{
  d1= copy(left)
  d2= copy(right)
  
  if (retainOrder) {
    d1[, order.id:= 1:.N]
  }
  pass.checks= T
  
  if (!keys %in% names(d1) || !keys %in% names(d2)) {
    print('ERROR! Keys not found in table(s)')
    pass.checks=F
  }
  
  result= data.table()
  if (pass.checks){
    setkeyv(d1, keys)
    setkeyv(d2, keys)
    result= d2[d1]
    if (retainOrder){
      result= result[order(order.id)]
      result[, order.id:= NULL]
    }
  }
  return (list(pass.checks, result))
}

findMode.categorical = function(dt, colname)
{
  dt= copy(dt)
  setnames(dt, colname, 'targ')
  agg.counts= dt[, list(freqs= .N), by= targ]
  agg.counts[, is.mode:= freqs==max(freqs)]
  theMode= agg.counts[is.mode==T]$targ
  setnames(agg.counts, 'targ',colname)
  return(list(theMode,agg.counts))
}

findMode = function(dt, colname)
{
  dt= copy(dt)
  setnames(dt, colname, 'targ')
  
  if (is.character(dt$arg) | is.factor(dt$targ)){
    method=1
  } else if (is.integer(dt$arg) | is.numeric(dt$targ)){
    method=2
  } else {
    print('Unsupported data type in argument \'colname\'')
  }
  setnames(dt, 'targ', colname)
  if (method==1){
    out= findMode.categorical(dt, colname)
  } else if (method==2) {
    out= findMode.numeric(dt, colname)
  } else {
    out= NULL
  }
  return(out)
}
