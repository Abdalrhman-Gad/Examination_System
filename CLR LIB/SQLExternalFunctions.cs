using System;
using System.Net.Http;
using System.Text;
using System.Text.Json;


public static class SQLExternalFunctions
{
    [Microsoft.SqlServer.Server.SqlFunction]
    public static float GetMatchingvalue(string question, string questionAnswer, string studentAnswer)
    {

        HttpClient client = new HttpClient();
        client.BaseAddress = new Uri("https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=AIzaSyA5kEGugYA16XkjSkIvq5yQjIgSYZw23SA");

        var jsonPayload = new
        {
            contents = new[]
            {
                new
                {
                    parts = new[]
                    {
                        new { text = $"As an Instructor, you have posed the following question in an exam: \"{question}\" and provided the answer: \"{questionAnswer}\" A student has answered: \"{studentAnswer}\" Compare both the instructor's answer and the student's answer, and return only the percentage similarity between the two answers, rounded to two decimal places." }
                    }
                }
            }
        };

        try
        {

            string contentJson = JsonSerializer.Serialize(jsonPayload);
            var content = new StringContent(contentJson, Encoding.UTF8, "application/json");

            var response = client.PostAsync(client.BaseAddress, content).Result;
            if (!response.IsSuccessStatusCode)
            {
                return -1;
            }
            string responseBody = response.Content.ReadAsStringAsync().Result;

            JsonDocument doc = JsonDocument.Parse(responseBody);
            var percentage = doc.RootElement
                .GetProperty("candidates")[0]
                .GetProperty("content")
                .GetProperty("parts")[0]
                .GetProperty("text")
                .GetString()
                .Trim();

            return float.Parse(percentage);
        }
        catch
        {

            return -1;
        }

    }
}
