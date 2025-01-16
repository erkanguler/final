using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using final.Models;

namespace final.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CustomerNoLoginController : ControllerBase
    {
        private readonly EcommerceContext _context;

        public CustomerNoLoginController(EcommerceContext context)
        {
            _context = context;
        }

        // GET: api/CustomerNoLogin
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CustomerNoLogin>>> GetCustomerNoLogins()
        {
            return await _context.CustomerNoLogins.ToListAsync();
        }

        // GET: api/CustomerNoLogin/5
        [HttpGet("{id}")]
        public async Task<ActionResult<CustomerNoLogin>> GetCustomerNoLogin(int id)
        {
            var customerNoLogin = await _context.CustomerNoLogins.FindAsync(id);

            if (customerNoLogin == null)
            {
                return NotFound();
            }

            return customerNoLogin;
        }

        // PUT: api/CustomerNoLogin/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCustomerNoLogin(int id, CustomerNoLogin customerNoLogin)
        {
            if (id != customerNoLogin.Id)
            {
                return BadRequest();
            }

            _context.Entry(customerNoLogin).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CustomerNoLoginExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/CustomerNoLogin
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<CustomerNoLogin>> PostCustomerNoLogin(CustomerNoLogin customerNoLogin)
        {
            _context.CustomerNoLogins.Add(customerNoLogin);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetCustomerNoLogin", new { id = customerNoLogin.Id }, customerNoLogin);
        }

        // DELETE: api/CustomerNoLogin/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCustomerNoLogin(int id)
        {
            var customerNoLogin = await _context.CustomerNoLogins.FindAsync(id);
            if (customerNoLogin == null)
            {
                return NotFound();
            }

            _context.CustomerNoLogins.Remove(customerNoLogin);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool CustomerNoLoginExists(int id)
        {
            return _context.CustomerNoLogins.Any(e => e.Id == id);
        }
    }
}
