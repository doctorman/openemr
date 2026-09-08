<?php

/**
 * Regression coverage for Eye Mag age-at-encounter rendering on PHP 8.
 *
 * The Eye Mag view has the raw encounter date available from its encounter
 * query. menu_overhaul_left() previously failed to receive that value and
 * substituted an empty string. With age_display_format=1, the empty string
 * reached PatientService::getPatientAgeYMD() and caused a TypeError during
 * date arithmetic on PHP 8.
 *
 * @package   OpenEMR
 * @link      https://www.open-emr.org
 * @author    OpenEMR Contributors
 * @copyright Copyright (c) 2026 OpenEMR Contributors
 * @license   https://github.com/openemr/openemr/blob/master/LICENSE GNU General Public License 3
 */

declare(strict_types=1);

namespace OpenEMR\Tests\Isolated\Forms\EyeMag;

use PHPUnit\Framework\Attributes\Group;
use PHPUnit\Framework\Attributes\Test;
use PHPUnit\Framework\TestCase;

#[Group('isolated')]
class EncounterAgeDisplayTest extends TestCase
{
    private string $functionsSource;
    private string $viewSource;

    protected function setUp(): void
    {
        $root = dirname(__DIR__, 5);
        $functionsPath = $root . '/interface/forms/eye_mag/php/eye_mag_functions.php';
        $viewPath = $root . '/interface/forms/eye_mag/view.php';

        $functions = file_get_contents($functionsPath);
        $view = file_get_contents($viewPath);
        $this->assertNotFalse($functions, "Could not read {$functionsPath}");
        $this->assertNotFalse($view, "Could not read {$viewPath}");

        $this->functionsSource = $functions;
        $this->viewSource = $view;
    }

    #[Test]
    public function menuReceivesEncounterDateAndDoesNotUseEmptyStringFallback(): void
    {
        $this->assertStringContainsString(
            'function menu_overhaul_left($pid, $encounter, ?string $encounter_date = null): void',
            $this->functionsSource
        );
        $this->assertStringContainsString(
            "getPatientAgeDisplay(\$pat_data['DOB'], \$encounter_date)",
            $this->functionsSource
        );
        $this->assertStringNotContainsString(
            "getPatientAgeDisplay(\$pat_data['DOB'], (\$encounter_date ?? ''))",
            $this->functionsSource
        );
    }

    #[Test]
    public function viewPassesRawEncounterDateToMenu(): void
    {
        $this->assertStringContainsString(
            "menu_overhaul_left(\$pid, \$encounter, \$encounter_data['encounter_date'] ?? null);",
            $this->viewSource
        );
    }
}
