export async function fetchNui(eventName,data) {
    const options = {
      method: 'post',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: JSON.stringify(data),
    }
  
    const resourceName = 'jerzys_management'
    const resp = await fetch(`https://${resourceName}/${eventName}`, options)
  
    const respFormatted = await resp.json()
    
    return respFormatted
}
  