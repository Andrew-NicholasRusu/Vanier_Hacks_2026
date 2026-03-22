var url = "http://ctf26.vanierhacks.net/testingCategory/testingName"

const response = await fetch(url, {
    method: "POST",
    headers: {
        "Content-Type": "application/json"
    },
    body: JSON.stringify({
        verificationCode: "test-uuid"
    })
});

console.log(await response.json());
