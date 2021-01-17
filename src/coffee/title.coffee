export TITLE = document.title
export default (title)=>
  if title
    title = title + " · " + TITLE
  else
    title = TITLE
  document.title = title

