const axios = require('axios')

for(let i = 0; i< 1; i++){
    axios
  .post('https://hitechmidnapore.in/submit.php')
  .then(res => {
    console.log(`statusCode: ${res.status}`)
    // console.log(res)
  })
  .catch(error => {
    console.error(error)
  })

}

