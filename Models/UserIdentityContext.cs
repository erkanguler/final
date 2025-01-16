using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

public class UserIdentityContext : IdentityDbContext<IdentityUser>
{
    public UserIdentityContext(DbContextOptions<UserIdentityContext> options) :
        base(options)
    { }
}