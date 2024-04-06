var builder = WebApplication.CreateBuilder(args);

var app = builder.Build();

var scores = new List<Score>();

app.MapGet("/scores", () =>
{
    scores.Sort((a, b) => b.Value.CompareTo(a.Value));
    return scores;
});

app.MapPost("/scores", (Score score) =>
{
    scores.RemoveAll(s => s.Name == score.Name);
    scores.Add(score);
    return Results.Created($"/scores", score);
});

app.MapDelete("/scores", () =>
{
    scores.Clear();
    return Results.NoContent();
});

app.Run();

record Score(string Name, int Value);